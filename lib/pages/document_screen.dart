import 'package:date_matching/pages/sub_pages/widget_discovery_card.dart';
import 'package:date_matching/pages/sub_pages/widget_principle_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sub_pages/page_edit_profile.dart';
import 'sub_pages/widget_discovery_card.dart';
// class DemoDocumentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DocumentScreen(
//       userName: '赵琰冰',
//       userIdentity: '',
//       ultimateGoal1: 'To understand the world',
//       ultimateGoal2: 'To impact the world',
//       ultimateGoal3: 'To learn/evolve',
//       avatar: Image.asset('lib/assets/figure4.png'),
//     );
//   }
// }

//“我”页面
class DocumentScreen extends StatelessWidget {
  // DocumentScreen({
  //   Key key,
  //   this.userName,
  //   this.userIdentity,
  //   this.ultimateGoal1,
  //   this.ultimateGoal2,
  //   this.ultimateGoal3,
  //   this.avatar,
  // }) : super(key: key); //constructor?

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<NameAndMessage>(context).userName;
    final userIdentity = Provider.of<NameAndMessage>(context).userIdentity;
    final ultimateGoal1 = Provider.of<NameAndMessage>(context).ultimateGoal1;
    final ultimateGoal2 = Provider.of<NameAndMessage>(context).ultimateGoal2;
    final ultimateGoal3 = Provider.of<NameAndMessage>(context).ultimateGoal3;
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
      body: 
      ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          BigPersonalTile(
            
            
                userName: userName,
                userIdentity: userIdentity,
              
              followed: 23,
              thumbnail: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/figure1.png'),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            
          ),
          ListTile(
            title: Text('终极目标'),
            subtitle: Text('$ultimateGoal1,$ultimateGoal2,$ultimateGoal3'),
          ),
          Text(
            '''
            TODO :
            我的目标原则左
            滑打开菜单添加删除，
            floating 添加原则。

            添加原则=》向服务器申请=》服务器生成用户的新原则，向手机发送UUID=》手机编辑原则，向服务器提交文本和UUID=》服务器存储信息=》向手机发送成功信号=》应用自动刷新“我的原则”界面。
            ''',
            textScaleFactor: 2,
          ),
        ],
      ),
    );
  }
}
