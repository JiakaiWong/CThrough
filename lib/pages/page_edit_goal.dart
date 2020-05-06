import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget_edit_goal_utility.dart';

class EditGoal extends StatefulWidget {
  @override
  _EditGoalState createState() => _EditGoalState();
}

class _EditGoalState extends State<EditGoal> {
  Widget futureWidget() {
    String uuid;
    String tuid;
    String goal_setted;
    String problems_identified;
    String root_causes_identified;
    String plan_designed;
    String action_performed;

    Future<bool> Failure1() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('出错。'),
              content: new Text('不能获取当前目标内容'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('Navigator'));
                  },
                  child: new Text('确定'),
                ),
              ],
            ),
          )) ??
          false;
    }

    Future<bool> Failure2() async {
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

    Future<Null> EditGoal() async {
      Response response;
      try {
        var data = {
          'uuid': uuid,
          'tuid': tuid,
          'goal': goal_setted,
          'problem': problems_identified,
          'reason': root_causes_identified,
          'plan': plan_designed,
          'action': action_performed
        };
        response = await post(
          "http://47.107.117.59/fff/setTarget.php", //TODO
          body: data,
        );
        Map<String, dynamic> mapFromJson =
            json.decode(response.body.toString());
        if (mapFromJson['status'] == 10000) {
          Navigator.pop(context);
          print('编辑成功');
        } else if (mapFromJson['status'] == 20000) {
          Failure2();
        }
      } on Error catch (e) {
        Failure2();
      }
      return;
    }

    //get uuid from local shared_preference
    Future<String> getUuid() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      uuid = prefs.getString('uuid');
      return uuid;
    }

    Future getTheGoal() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set tuid
      tuid = prefs.getString('currentGoal');
    }

    Future<String> getThingsDone() async {
      print('编辑页面开始读取信息');
      getUuid();
      getTheGoal().then((response) {
        print('找到目标，开始给文本框内容赋值');
        var foundTarget = false;
        for (int i = 0; i < listOfBareFiveStep.length; i++) {
          print(listOfBareFiveStep[i].uuid);
          print(listOfBareFiveStep[i].goal_setted);
          print(listOfBareFiveStep[i].problems_identified);
          print(listOfBareFiveStep[i].root_causes_identified);
          print(listOfBareFiveStep[i].plan_designed);
          print(listOfBareFiveStep[i].action_performed);

          if (listOfBareFiveStep[i].uuid == tuid) {
            goal_setted = listOfBareFiveStep[i].goal_setted;
            problems_identified = listOfBareFiveStep[i].problems_identified;
            root_causes_identified =
                listOfBareFiveStep[i].root_causes_identified;
            plan_designed = listOfBareFiveStep[i].plan_designed;
            action_performed = listOfBareFiveStep[i].action_performed;
            foundTarget = true;
          }
        }
        if (!foundTarget) {
          Failure1();
        }
      });
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
              {
                print('开始生成编辑目标的页面');
                print(tuid);
                print(goal_setted);
                print(problems_identified);
                print(root_causes_identified);
                print(plan_designed);
                print(action_performed);
                return new Scaffold(
                  appBar: AppBar(
                    title: Text('编辑目标'),
                    elevation: 0,
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            EditGoal();
                          })
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: ListView(
                        children: <Widget>[
                          NewGoal1Direction(),
                          TextField(
                            controller:
                                TextEditingController(text: goal_setted),
                            onChanged: (text) {
                              goal_setted = text;
                            },
                            decoration: InputDecoration(
                                hintText: '目标',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLength: 300,
                            maxLines: 10,
                          ),
                          NewGoal2Direction(),
                          TextField(
                            controller: TextEditingController(
                                text: problems_identified),
                            onChanged: (text) {
                              problems_identified = text; //TODO
                            },
                            decoration: InputDecoration(
                                hintText: '障碍识别',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLength: 300,
                            maxLines: 10,
                          ),
                          NewGoal3Direction(),
                          TextField(
                            controller: TextEditingController(
                                text: root_causes_identified),
                            onChanged: (text) {
                              root_causes_identified = text;
                            },
                            decoration: InputDecoration(
                                hintText: '障碍背后的根本原因',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLength: 300,
                            maxLines: 10,
                          ),
                          NewGoal4Direction(),
                          TextField(
                            controller:
                                TextEditingController(text: plan_designed),
                            onChanged: (text) {
                              plan_designed = text;
                            },
                            decoration: InputDecoration(
                                hintText: '计划',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLength: 300,
                            maxLines: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '计划执行情况',
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                    fontSize: 42.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TextField(
                            controller:
                                TextEditingController(text: action_performed),
                            onChanged: (text) {
                              action_performed = text;
                            },
                            decoration: InputDecoration(
                                hintText: '计划执行情况',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLength: 300,
                            maxLines: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return futureWidget();
  }
}
