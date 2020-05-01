import 'package:flutter/material.dart';


class DemoDocumentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DocumentScreen(
      userName: '名字',
      userIdentity: '',
      ultimateGoal1: 'To understand the world',
      ultimateGoal2: 'To impact the world',
      ultimateGoal3: 'To learn/evolve',
      avatar: Image.asset('lib/assets/figure4.png'),
    );
  }
}

//“我”页面
class DocumentScreen extends StatelessWidget {
  DocumentScreen({
    Key key,
    this.userName,
    this.userIdentity,
    this.ultimateGoal1,
    this.ultimateGoal2,
    this.ultimateGoal3,
    this.avatar,
  }) : super(key: key); //constructor?
  final String userName;
  final String userIdentity;
  final String ultimateGoal1;
  final String ultimateGoal2;
  final String ultimateGoal3;
  final Image avatar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
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
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Align(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     image: avatar.image,
                      //     //fit: BoxFit.fill,
                      //   ),
                      //   shape: BoxShape.circle,
                      // ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Center(
                    child: Text(
                      '$userName',
                      textScaleFactor: 3,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 7,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: Icon(
                      Icons.verified_user,
                      color: userIdentity ==''||userIdentity==null?Colors.grey : Colors.green,
                    ),
                  ),
                ),
                Expanded(flex: 4, child: Text('$userIdentity')),
              ],
            ),
          ),

          ListTile(
            title: Text('终极目标'),
            subtitle: Text(
                '&ultimateGoal1,$ultimateGoal2,$ultimateGoal3'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'EditProfileScreen');
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  '编辑个人信息',
                ),
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'ViewFollowing');
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  '我的关注列表',
                ),
              ),
            ),
          ),
          //GoalAndObstaclesExtensionListView(),
        ],
      ),
    );
  }
}
