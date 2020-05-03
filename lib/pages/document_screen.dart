import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'widget_principle_card.dart';
import 'page_edit_profile.dart';
import 'widget_discovery_card.dart';

Future<String> _loadDocumentFile() async {
  return await rootBundle.loadString('lib/assets/Document.json');
}

Future wait(int milliseconds) {
  return new Future.delayed(Duration(milliseconds: milliseconds), () => {});
}

Future<PersonTileData> loadDocument() async {
  await wait(1000);
  String jsonString = await _loadDocumentFile();
  final jsonResponse = json.decode(jsonString);
  return new PersonTileData.fromJson(jsonResponse);
}

class MyPersonTile extends StatefulWidget {
  @override
  _MypersonTileState createState() => _MypersonTileState();
}

class _MypersonTileState extends State<MyPersonTile> {
  Widget futureWidget() {
    return new FutureBuilder<PersonTileData>(
        future: loadDocument(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BigPersonalTile(
              userName: snapshot.data.userName,
              userIdentity: snapshot.data.userIdentity,
              followed: snapshot.data.followed,
              thumbnail: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/assets/avatar/${snapshot.data.avatarId}.png'),
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

class DocumentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          // ListTile(
          //   title: Text('终极目标'),
          //   subtitle: Text('$ultimateGoal1,$ultimateGoal2,$ultimateGoal3'),
          // ),
          // Text(
          //   '''
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
