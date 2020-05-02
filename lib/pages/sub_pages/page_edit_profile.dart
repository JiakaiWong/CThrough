import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class NameAndMessage {
  String userName;
  String userIdentity;
  String ultimateGoal1;
  String ultimateGoal2;
  String ultimateGoal3;
  NameAndMessage(this.userName, this.userIdentity, this.ultimateGoal1,
      this.ultimateGoal2, this.ultimateGoal3);
}

class ProfileNotifier with ChangeNotifier {
  NameAndMessage myNameAndMessage;
  NameAndMessage get value => myNameAndMessage;
  void set(final NameAndMessage newNameAndMessage) {
    myNameAndMessage = newNameAndMessage;
    notifyListeners();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人公开资料'),
        elevation: 0,
        leading: new Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Consumer2<ProfileNotifier, NameAndMessage>(
              builder: (context, ProfileNotifier myProfileNotifier,
                      NameAndMessage myNameAndMessage, _) =>
                  TextField(
                onChanged: (text) {
                  myNameAndMessage.userName = text;
                },
                controller:
                    TextEditingController(text: myNameAndMessage.userName),
                decoration: InputDecoration(
                    labelText: '昵称',
                    labelStyle: TextStyle(),
                    hintText: '昵称',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                maxLength: 100,
              ),
            ),
            Consumer2<ProfileNotifier, NameAndMessage>(
              builder: (context, ProfileNotifier myProfileNotifier,
                      NameAndMessage myNameAndMessage, _) =>
                  TextField(
                onChanged: (text) {
                  myNameAndMessage.userIdentity = text;
                },
                controller:
                    TextEditingController(text: myNameAndMessage.userIdentity),
                decoration: InputDecoration(
                    labelText: '认证信息（所属高中/大学/再读学历)',
                    hintText: '认证信息（所属高中/大学/再读学历）',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                maxLength: 100,
              ),
            ),
            Consumer2<ProfileNotifier, NameAndMessage>(
              builder: (context, ProfileNotifier myProfileNotifier,
                      NameAndMessage myNameAndMessage, _) =>
                  TextField(
                onChanged: (text) {
                  myNameAndMessage.ultimateGoal1 = text;
                },
                controller:
                    TextEditingController(text: myNameAndMessage.ultimateGoal1),
                decoration: InputDecoration(
                    labelText: '核心目标1',
                    hintText: '核心目标1',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                maxLength: 100,
              ),
            ),
            Consumer2<ProfileNotifier, NameAndMessage>(
              builder: (context, ProfileNotifier myProfileNotifier,
                      NameAndMessage myNameAndMessage, _) =>
                  TextField(
                onChanged: (text) {
                  myNameAndMessage.ultimateGoal2 = text;
                },
                controller:
                    TextEditingController(text: myNameAndMessage.ultimateGoal2),
                decoration: InputDecoration(
                    labelText: '核心目标2',
                    hintText: '核心目标2',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                maxLength: 100,
              ),
            ),
            Consumer2<ProfileNotifier, NameAndMessage>(
              builder: (context, ProfileNotifier myProfileNotifier,
                      NameAndMessage myNameAndMessage, _) =>
                  TextField(
                onChanged: (text) {
                  myNameAndMessage.ultimateGoal3 = text;
                },
                controller:
                    TextEditingController(text: myNameAndMessage.ultimateGoal3),
                decoration: InputDecoration(
                    labelText: '核心目标3',
                    hintText: '核心目标3',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                maxLength: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
