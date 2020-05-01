import 'package:flutter/material.dart';

class DocumentScreen extends StatelessWidget {
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
          // 用fittedbox来放图片

          // ConfigurableExpansionTile(
          //   headerExpanded:
          //       Flexible(child: Center(child: Text("A Header Changed"))),
          //   header: Container(child: Center(child: Text("A Header"))),
          //   children: [
          //     Row(
          //       children: <Widget>[Text("CHILD 1")],
          //     ),
          //     // + more params, see example !!
          //   ],
          // ),

          Center(
            child: Container(
              child: Text(
                '张三丰',
                textScaleFactor: 3,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 7,
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: Icon(
                      Icons.verified_user,
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(flex: 4, child: Text('华南理工大学')),
                Expanded(
                  flex: 4,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'EditProfileScreen');
                    },
                    child: Container(
                      height: 30,
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
                )
              ],
            ),
          ),
          ListTile(
            subtitle: Text('目标树'),
            isThreeLine: false,
          ),
          ListTile(
            title: Text('终极目标'),
            subtitle: Text(
                'To understand the world, To impact the world, To learn/evolve'),
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
