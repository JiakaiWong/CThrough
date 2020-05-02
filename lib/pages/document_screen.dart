import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sub_pages/page_edit_profile.dart';
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
  final  userIdentity= Provider.of<NameAndMessage>(context).userName;
  final  ultimateGoal1 = Provider.of<NameAndMessage>(context).userName;
  final  ultimateGoal2 = Provider.of<NameAndMessage>(context).userName;
  final  ultimateGoal3 = Provider.of<NameAndMessage>(context).userName;
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
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Align(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('figure1.jpg'),
                          //fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                      ),
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
                      color: userIdentity == '' || userIdentity == null
                          ? Colors.grey
                          : Colors.green,
                    ),
                  ),
                ),
                Expanded(flex: 4, child: Text('$userIdentity')),
              ],
            ),
          ),

          ListTile(
            title: Text('终极目标'),
            subtitle: Text('$ultimateGoal1,$ultimateGoal2,$ultimateGoal3'),
          ),
          
        ],
      ),
    );
  }
}
