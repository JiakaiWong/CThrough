import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPrinciplePage extends StatefulWidget {
  @override
  _NewPrinciplePageState createState() => _NewPrinciplePageState();
}

class _NewPrinciplePageState extends State<NewPrinciplePage> {
  Widget futureWidget() {
    String principleText = '';
    String principleDescription = '';
    final puid = Uuid().v1();
    var uuid;
    //get uuid from local shared_preference
    Future<String> getUuid() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      uuid = prefs.getString('uuid');
      return uuid;
    }

    Future<bool> Failure() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('出错。'),
              content: new Text('内容未保存，请手动保存至应用外'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text('确定'),
                ),
              ],
            ),
          )) ??
          false;
    }

    Future<Null> EditPrinciple() async {
      Response response;
      try {
        var data = {
          'uuid': uuid,
          'puid': puid,
          'title': principleText,
          'description': principleDescription,
        };
        print(data);
        response = await post(
          "http://47.107.117.59/fff/setPrinciple.php", //TODO
          body: data,
        );
        print('response got');
        Map<String, dynamic> mapFromJson =
            json.decode(response.body.toString());
        print(response.body.toString());
        if (mapFromJson['status'] == 10000) {
          print('新建原则成功');
          Navigator.pop(context);
          print('请求成功');
        }
      } on Error catch (e) {
        print(e);
        Failure();
      }
      return;
    }

    return new FutureBuilder(
        future: getUuid(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: new CircularProgressIndicator()); 
            case ConnectionState.waiting:
              return Center(child: new CircularProgressIndicator());
            default: 
              if (snapshot.hasError) 
                return new Text('Error: ${snapshot.error}');
              else 
                return new Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      tooltip: '取消编辑并且返回',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(''),
                    elevation: 0,
                    actions: <Widget>[
                      IconButton(icon: Icon(Icons.check), onPressed: (){EditPrinciple();})
                    ],
                    
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: ListView(
                        children: <Widget>[
                          
                          TextField(
                            onChanged: (text) {
                              principleText = text;
                            },
                            decoration: InputDecoration(
                                hintText: '原则',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLength: 300,
                            maxLines: 10,
                          ),
                          TextField(
                            onChanged: (text) {
                              principleDescription = text;
                            },
                            decoration: InputDecoration(
                                hintText: '原则详情',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLength: 300,
                            maxLines: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return futureWidget();
  }
}
