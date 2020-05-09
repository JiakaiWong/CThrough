import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Widget futureWidget() {
    String title = '';
    String content = '';
    String password = '';
    String uuid = '7ab23f50-8e19-11ea-f37d-13590433e3bd';
    // //get uuid from local shared_preference
    Future<String> getUuid() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      uuid = prefs.getString('uuid');
      uuid = '7ab23f50-8e19-11ea-f37d-13590433e3bd';
      String myUuid = uuid;
      return myUuid;
    }

    // Future getTHingsDone() async {
    //   getUuid().then(() {
    //     print(uuid);
    //   });
    // }

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

    Future<bool> WrongPassword() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('密码不正确'),
              content: new Text('你不是管理员？'),
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

    Future<Null> SendNotification() async {
      Response response;
      if (password != 'password') {
        WrongPassword();
      } else {
        try {
          var data = {
            'uuid': uuid,
            'title': title,
            'content': content,
          };
          print(data);
          response = await post(
            "http://47.107.117.59/fff/setNotice.php", //TODO
            body: data,
          );
          print('response got');
          Map<String, dynamic> mapFromJson =
              json.decode(response.body.toString());
          print(response.body.toString());
          if (mapFromJson['status'] == 10000) {
            print('通知发布成功');
            Navigator.pop(context);
            print('请求成功');
          }
        } on Error catch (e) {
          print(e);
          Failure();
        }
        return;
      }
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(''),
                    elevation: 0,
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            SendNotification();
                          })
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: ListView(
                        children: <Widget>[
                          TextField(
                            onChanged: (text) {
                              title = text;
                            },
                            decoration: InputDecoration(
                                hintText: '标题',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLength: 300,
                            maxLines: 10,
                          ),
                          TextField(
                            onChanged: (text) {
                              content = text;
                            },
                            decoration: InputDecoration(
                                hintText: '内容',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLength: 300,
                            maxLines: 10,
                          ),
                          TextField(
                            onChanged: (text) {
                              password = text;
                            },
                            decoration: InputDecoration(
                                hintText: '管理员密码',
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
