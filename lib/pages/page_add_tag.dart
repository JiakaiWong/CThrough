import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'widget_edit_goal_utility.dart';

class addTagPage extends StatefulWidget {
  @override
  _AddTagPageState createState() =>
      _AddTagPageState();
}

class _AddTagPageState extends State<addTagPage> {
  Widget futureWidget() {
    String tag = '';
    final tuid = Uuid().v1();
    changeCurrentGoal() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('currentGoal', "$tuid");
    }
//init
    Future<String> getThingsDone() async {
      changeCurrentGoal();
    }

    Future<bool> Failure() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('出错。'),
              content: new Text('内容未保存，请手动保存至应用外'),
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

    Future<Null> AddTag() async {
      print('开始传Tag');
      Response response;
      try {
        var data = {
        
          'tuid': tuid,
          'tag': tag,
        };
        print(data);
        response = await post(
          "http://47.107.117.59/fff/setTagT.php", //TODO
          body: data,
        );

        print('response got');
        Map<String, dynamic> mapFromJson =
            json.decode(response.body.toString());
        print(response.body.toString());
        if (mapFromJson['status'] == 10000) {
          print('新建Tag成功');
          Navigator.pushReplacementNamed(context, 'NewGoal1');
        }
      } on Error catch (e) {
        print(e);
        Failure();
      }
      return;
    }

    return new FutureBuilder(
        future: getThingsDone(),
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
                    title: Text('先设定一个分类标签吧'),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      tooltip: '取消编辑并且返回',
                      onPressed: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('Navigator'));
                      },
                    ),
                    elevation: 0,
                    actions: <Widget>[
                      IconButton(
                        tooltip: '继续',
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          AddTag();
                        },
                      )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: ListView(
                        children: <Widget>[
                          TextField(
                            onChanged: (text) {
                              tag = text;
                            },
                            decoration: InputDecoration(
                                hintText: '标签',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLength: 10,
                            maxLines: 1,
                          ),
                          Text('请为这个目标添加一个标签用于分类，如‘留学申请’、‘考研’'),
                        ],
                      ),
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
