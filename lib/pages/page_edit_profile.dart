import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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

    Future<bool> Success() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('修改成功'),
              content: new Text(''),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('Navigator'));
                  },
                  child: new Text('确定'),
                ),
              ],
            ),
          )) ??
          false;
    }

    Future<bool> PickAvatarSuccess() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('已选择新头像'),
              content: new Text(''),
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
    Future<String> getUuid() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      personTileData.uuid = prefs.getString('uuid');
      return personTileData.uuid;
    }

    Future<Null> GetPersonTileData() async {
      var myuuid = await getUuid();
      print('begin async');
      Response response;
      print('before try:');
      print(myuuid);
      try {
        var data = {'uuid': myuuid};
        print('when try:');
        print(myuuid);
        response = await post(
          "http://47.107.117.59/fff/getUserInfo.php",
          body: data,
        );
        Map<String, dynamic> mapFromJson = json.decode(response.body);
        print(mapFromJson);
        print(data);
        print(personTileData.uuid);
        if (mapFromJson['status'] == 10000) {
          print('请求成功');
          personTileData.avatarId = mapFromJson['avartarId'];
          personTileData.followed = mapFromJson['followed'];
          personTileData.userIdentity = mapFromJson['identity'];
          personTileData.userName = mapFromJson['nick'];
          print(personTileData.avatarId);
          print(personTileData.userName);
        } else if (mapFromJson['status'] == 20000) {
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("请求失败"),
            action: new SnackBarAction(
              label: "OK",
              onPressed: () {},
            ),
          ));
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
          'uuid': personTileData.uuid,
          'avartarId': personTileData.avatarId.toString(),
          'nick': personTileData.userName,
          'identity': personTileData.userIdentity,
          //'followed': personTileData.followed
        };
        print(data);
        response = await post(
          "http://47.107.117.59/fff/setUserInfo.php",
          body: data,
        );
        Map<String, dynamic> mapFromJson =
            json.decode(response.body.toString());
        print(response.body.toString());
        if (mapFromJson['status'] == 10000) {
          print('请求成功');
          Success();
          // Scaffold.of(context).showSnackBar(new SnackBar(
          //   content: new Text("修改成功"),
          //   action: new SnackBarAction(
          //     label: "完成",
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ));
        } else if (mapFromJson['status'] == 20000) {
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("请求失败"),
            action: new SnackBarAction(
              label: "OK",
              onPressed: () {},
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
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text(
                  'Press button to start'); //如果_calculation未执行则提示：请点击开始
            case ConnectionState.waiting:
              return Center(child: new CircularProgressIndicator());
            default: //如果_calculation执行完毕
              if (snapshot.hasError) //若_calculation执行出现异常
                return new Text('Error: ${snapshot.error}');
              else //若_calculation执行正常完成
                return new Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    //自动显示返回按钮
                    //leading: new Container(),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          sendPersonTileData();
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
                                                'lib/assets/avatar/${personTileData.avatarId.toString()}.jpg')),
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
                            personTileData.userName = text;
                          },
                          controller: TextEditingController(
                              text: personTileData.userName),
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
                            personTileData.userIdentity = text;
                          },
                          controller: TextEditingController(
                              text: personTileData.userIdentity),
                          decoration: InputDecoration(
                              labelText: '认证信息（所属高中/大学/在读学历)',
                              hintText: '认证信息（所属高中/大学/在读学历）',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                          maxLength: 100,
                        ),
                        Text('点击选择头像'),
                        Column(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: InkWell(
                                            onTap: () {
                                              personTileData.avatarId = 1;
                                              PickAvatarSuccess();
                                            },
                                            child: Container(
                                              //height: 60,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'lib/assets/avatar/1.jpg')),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1 /
                                                15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: InkWell(
                                            onTap: () {
                                              personTileData.avatarId = 2;
                                              PickAvatarSuccess();
                                            },
                                            child: Container(
                                              // height: 60,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'lib/assets/avatar/2.jpg')),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: InkWell(
                                            onTap: () {
                                              personTileData.avatarId = 3;
                                              PickAvatarSuccess();
                                            },
                                            child: Container(
                                              //height: 60,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'lib/assets/avatar/3.jpg')),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1 /
                                                15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: InkWell(
                                            onTap: () {
                                              personTileData.avatarId = 4;
                                              PickAvatarSuccess();
                                            },
                                            child: Container(
                                              // height: 60,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'lib/assets/avatar/4.jpg')),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: InkWell(
                                            onTap: () {
                                              personTileData.avatarId = 5;
                                              PickAvatarSuccess();
                                            },
                                            child: Container(
                                              //height: 60,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'lib/assets/avatar/5.jpg')),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1 /
                                                15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: InkWell(
                                            onTap: () {
                                              personTileData.avatarId = 6;
                                              PickAvatarSuccess();
                                            },
                                            child: Container(
                                              // height: 60,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'lib/assets/avatar/6.jpg')),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
