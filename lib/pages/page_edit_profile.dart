import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Widget futureWidget() {
    return new FutureBuilder<PersonTileData>(
        future: loadDocument(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'lib/assets/avatar/1.png')),
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
                        //TODO
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
                        //TODO
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
