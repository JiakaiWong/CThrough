import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class NameAndMessage {
  final String userName;
  final String userIdentity;
  final String ultimateGoal1;
  final String ultimateGoal2;
  final String ultimateGoal3;
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

//
//用consumer
//
class _EditProfilePageState extends State<EditProfilePage> {
  final myNameAndMessage = ProfileNotifier();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {},
        child: ChangeNotifierProvider.value(
          value: ProfileNotifier(),
          child: Builder(builder: (context) {
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
                    TextField(
                      controller: TextEditingController(text: "Initial Text here"),
                      decoration: InputDecoration(
                          hintText: '昵称',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                      maxLength: 100,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '核心目标1',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      maxLength: 100,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '核心目标2',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      maxLength: 100,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '核心目标3',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      maxLength: 100,
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
