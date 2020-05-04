import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget_discovery_card.dart';

// Future<String> _loadDocumentFile() async {
//   return await rootBundle.loadString('lib/assets/Document.json');
// }

// Future wait(int milliseconds) {
//   return new Future.delayed(Duration(milliseconds: milliseconds), () => {});
// }

// Future<PersonTileData> loadDocument() async {
//   await wait(1000);
//   String jsonString = await _loadDocumentFile();
//   final jsonResponse = json.decode(jsonString);
//   return new PersonTileData.fromJson(jsonResponse);
// }

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Widget futureWidget() {
    PersonTileData personTileData = PersonTileData(
      uuid: 'default',
      avatarId: 1,
      userName: '正在加载昵称',
      userIdentity: '正在加载身份',
      followed: 0,
    );
    PersonTileData newPersonTileData;

    Future<bool> Faliure() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('出错了'),
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

    //get uuid from local shared_preference
    void getUuid() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      personTileData.uuid = prefs.getString('uuid');
    }

    Future<Null> GetPersonTileData() async {
      getUuid();
      print('begin async');
      Response response;
      try {
        var data = {'uuid': personTileData.uuid};
        response = await post(
          "http://47.107.117.59/fff/register.php", //TODO
          body: data,
        );
        print(response.body.toString());
        if (response.statusCode == 200) {
          print('请求成功');
          personTileData = PersonTileData.fromJson(json.decode(response.body));
          newPersonTileData = personTileData;
        }
      } on Error catch (e) {
        print(e);
        Faliure();
      }
      return;
    }

    Future<Null> sendPersonTileData() async {
      print('begin async');
      Response response;
      try {
        var data = {
          'uuid': newPersonTileData.uuid,
          'avartarId': newPersonTileData.avatarId,
          'userName': newPersonTileData.userName,
          'userIdentity': newPersonTileData.userIdentity,
          'followed': newPersonTileData.followed
        };
        response = await post(
          "http://47.107.117.59/fff/register.php", //TODO
          body: data,
        );
        print(response.body.toString());
        if (response.statusCode == 104) {
          print('请求成功');
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("修改成功"),
            action: new SnackBarAction(
              label: "完成",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ));
        }
      } on Error catch (e) {
        print(e);
        Faliure();
      }
      return;
    }

    return new FutureBuilder<PersonTileData>(
        future: GetPersonTileData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                //自动显示返回按钮
                //leading: new Container(),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      //TODO
                      // Navigator.pop(context);
                    },
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Edit Profile',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                            fontSize: 42.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //一条线
                    Padding(
                      padding: EdgeInsets.only(left: 12.0, top: 4.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          color: Theme.of(context).accentColor,
                          width: 40.0,
                          height: 2.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1,
                              child: InkWell(
                                onTap: () {
                                  //TODO
                                  //进入头像选择界面
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'lib/assets/avatar/${newPersonTileData.avatarId}.png')),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        newPersonTileData.userName = text;
                      },
                      controller:
                          TextEditingController(text: snapshot.data.userName),
                      decoration: InputDecoration(
                          labelText: '昵称',
                          labelStyle: TextStyle(),
                          hintText: '昵称',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                      maxLength: 100,
                    ),
                    TextField(
                      onChanged: (text) {
                        newPersonTileData.userIdentity = text;
                      },
                      controller: TextEditingController(
                          text: snapshot.data.userIdentity),
                      decoration: InputDecoration(
                          labelText: '认证信息（所属高中/大学/再读学历)',
                          hintText: '认证信息（所属高中/大学/再读学历）',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                      maxLength: 100,
                    ),
                    FlatButton(
                        color: Colors.grey,
                        onPressed: () {
                          //TODO
                          Navigator.pop(context);
                        },
                        child: Text('完成'))
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return new Text("${snapshot.hasError}");
          }
          return Center(child: new CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return futureWidget();
  }
}
