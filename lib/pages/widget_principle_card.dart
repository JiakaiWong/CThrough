import 'dart:convert';
import 'package:date_matching/pages/widget_edit_principle_utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPrinciplePage extends StatefulWidget {
  MyPrinciplePage({Key key}) : super(key: key);

  @override
  _MyPrinciplePageState createState() => _MyPrinciplePageState();
}

class _MyPrinciplePageState extends State<MyPrinciplePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  

  Future<bool> Failure() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('出错'),
            content: new Text('请稍后再试'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  //get puid from local shared_preference
  Future<String> getUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var myuuid = prefs.getString('uuid');
    return myuuid;
  }

  Future<int> GetMyPrincipleData() async {
    var myuuid = await getUuid();
    print('begin GetMyPrincipleData');
    Response response;
    try {
      var data = {'uuid': myuuid};
      print(data);
      response = await post(
        "http://47.107.117.59/fff/getPrinciples.php",
        body: data,
      );
      var principleMapFromJson = json.decode(response.body);
      listOfBarePrinciple.removeRange(0, listOfBarePrinciple.length);

      if (principleMapFromJson['status'] == 10000) {
        for (int i = 0; i < (principleMapFromJson['sum'] as int); i++) {
          listOfBarePrinciple.add(BarePrinciple(
            puid: 'default puid',
            principleText: ' ',
            principleDescription: ' ',
          ));
        }
        for (int i = 0; i < (principleMapFromJson['sum'] as int); i++) {
          listOfBarePrinciple[i].puid =
              principleMapFromJson['results'][i]['puid'];
          listOfBarePrinciple[i].principleText =
              principleMapFromJson['results'][i]['title'];
          listOfBarePrinciple[i].principleDescription =
              principleMapFromJson['results'][i]['description'];
        }
        print('我的原则列表存储结束,长度为：');
        print(listOfBarePrinciple.length);
      } else if (principleMapFromJson['status'] == 20000) {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');

      Failure();
    }
    return listOfBarePrinciple.length;
  }

  Future DeletePrinciple(String puid) async {
    print('开始删除原则');
    Response response;
    try {
      var data = {'puid': puid};

      response = await post(
        "http://47.107.117.59/fff/deletePrinciple.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      if (mapFromJson['status'] == 10000) {
        print('删除成功');
      } else if (mapFromJson['status'] == 20000) {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');
      Failure();
    }
    
    
  }
  Widget futureWidget() {
      return new FutureBuilder(
          future: GetMyPrincipleData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('未请求');
              case ConnectionState.waiting:
                {
                  return new Text('Awaiting result...');
                } 
              default: 
                if (snapshot.hasError) {
                  print('snapshot.hasError');
                  return new Text('Error: ${snapshot.error}');
                } 
                else {
                  return new Scaffold(
                    body: new ListView.builder(
                        itemCount: snapshot.data,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              key: Key('keyOfFullPrincipleCard$index'),
                              onDismissed: (direction) {
                                var _snackStr = '删除了一个原则';
                                if (direction == DismissDirection.endToStart) {
                                  // 从右向左
                                  _snackStr = '从右向左删除了原则';
                                } else if (direction ==
                                    DismissDirection.startToEnd) {
                                  _snackStr = '从左向右删除了原则';
                                }
                                DeletePrinciple(listOfBarePrinciple[index].puid);
                                // 展示 SnackBar
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(_snackStr),
                                ));
                                setState(() {});
                              },
                              background: Container(
                                color: Colors.red,
                                child: ListTile(
                                  title: Text(
                                    '你快                    删除我啊',
                                    textScaleFactor: 2.0,
                                  ),
                                  leading: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  trailing: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              secondaryBackground: Container(
                                color: Colors.blue,
                                child: ListTile(
                                  title: Text(
                                    '''
                  你快
                  删除我啊
                                    ''',
                                    textScaleFactor: 2.0,
                                  ),
                                  trailing: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: FullPrincipleCard(
                                principleText:
                                    listOfBarePrinciple[index].principleText,
                                principleDescription: listOfBarePrinciple[index]
                                    .principleDescription,
                              ),
                            ),
                          );
                        }),
                    floatingActionButton: FloatingActionButton.extended(
                        label: Text('新的目标'),
                        heroTag: 'addPrinciple',
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          Navigator.pushNamed(context, 'NewPrinciple');
                          print(" Navigator.pushNamed(context, 'NewPrinciple');");
                        }),
                  );
                }
            }
          });
    }

  @override
    Widget build(BuildContext context) {
      return futureWidget();
    }
  
}
