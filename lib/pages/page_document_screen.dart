import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget_principle_card.dart';
import 'page_edit_profile.dart';
import 'widget_discovery_card.dart';

//用于异步读取本地json

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

//我的个人信息标签
class MyPersonTile extends StatefulWidget {
  @override
  _MypersonTileState createState() => _MypersonTileState();
}

class _MypersonTileState extends State<MyPersonTile> {
  Widget futureWidget() {
    PersonTileData personTileData = PersonTileData(
      uuid: 'default',
      avatarId: 1,
      userName: '正在加载昵称',
      userIdentity: '正在加载身份',
      followed: 0,
    );

    Future<bool> Faliure() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('无法获取个人信息'),
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
        Map<String, dynamic> mapFromJson =
            json.decode(response.body.toString());
        if (mapFromJson['status'] == 10000) {
          print('请求成功');
          personTileData.avatarId = mapFromJson['avatarId'];
          personTileData.followed = mapFromJson['followed'];
          personTileData.userIdentity = mapFromJson['userIdentity'];
          personTileData.userName = mapFromJson['userName'];
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
            return BigPersonalTile(
              //在futur builder 中返回一个个人资料栏
              userName: snapshot.data.userName,
              userIdentity: snapshot.data.userIdentity,
              followed: snapshot.data.followed,
              thumbnail: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/assets/avatar/${personTileData.avatarId}.png'),
                    ),
                    shape: BoxShape.circle,
                  ),
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

//我的个人信息页面
class DocumentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //below are only for Provider-Consumer
    // final ultimateGoal1 = Provider.of<NameAndMessage>(context).ultimateGoal1;
    // final ultimateGoal2 = Provider.of<NameAndMessage>(context).ultimateGoal2;
    // final ultimateGoal3 = Provider.of<NameAndMessage>(context).ultimateGoal3;
    //final Image avatar;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'EditProfileScreen');
          },
          icon: Icon(Icons.edit),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.alternate_email),
            onPressed: () {
              Navigator.pushNamed(context, 'AboutPage');
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          MyPersonTile(),
          //   TODO :
          //   我的目标原则左
          //   滑打开菜单添加删除，
          //   floating 添加原则。
          //   添加原则=》向服务器申请=》服务器生成用户的新原则，向手机发送UUID=》手机编辑原则，向服务器提交文本和UUID=》服务器存储信息=》向手机发送成功信号=》应用自动刷新“我的原则”界面。
          //   ''',
          //   textScaleFactor: 2,
          // ),
        ],
      ),
    );
  }
}
