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

    //get uuid from local shared_preference
    Future<String> getUuid() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      uuid = prefs.getString('uuid');
      return uuid;
    }

    void getTheGoal() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set tuid
      tuid = prefs.getString('currentGoal');
    }

    Future<String> getThingsDone() async {
      print('编辑目标开始读取信息');
      getUuid();
      getTheGoal();
      for (int i = 0; i < itemCount; i++) {
        if (listOfBareFiveStep[i].uuid == tuid) {
          goal_setted = listOfBareFiveStep[i].goal_setted;
          goal_setted = listOfBareFiveStep[i].problems_identified;
          goal_setted = listOfBareFiveStep[i].root_causes_identified;
          goal_setted = listOfBareFiveStep[i].plan_designed;
          goal_setted = listOfBareFiveStep[i].action_performed;
        }
      }
    }

    // void getTheGoalSetted() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   //set uuid
    //   goal_setted = prefs.getString('currentGoalSetted');
    // }

    // void getTheProblemsIdentified() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   //set uuid
    //   problems_identified = prefs.getString('currentProblemsIdentified');
    // }

    // void getTheRootCausesIdentified() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   //set uuid
    //   root_causes_identified = prefs.getString('currentRootCausesIdentified');
    // }

    // void getTheActionPerformed() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   //set uuid
    //   root_causes_identified = prefs.getString('currentRootCausesIdentified');
    // }

    // void getCurrentActionPerformed() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   //set uuid
    //   action_performed = prefs.getString('currentActionPerformed');
    // }

    Future<bool> Faliure1() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('出错。'),
              content: new Text('不能获取当前目标内容'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {},
                  child: new Text('确定'),
                ),
              ],
            ),
          )) ??
          false;
    }

    Future<bool> Faliure2() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('出错。'),
              content: new Text('内容未保存，请手动保存至应用外'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {},
                  child: new Text('确定'),
                ),
              ],
            ),
          )) ??
          false;
    }

    Future<Null> EditGoal() async {
      print('begin async');
      Response response;
      try {
        var data = {
          'uuid': uuid,
          'goal_setted': goal_setted,
          'problems_identified': problems_identified,
          'root_causes_identified': root_causes_identified,
          'plan_designed': plan_designed,
          'action_performed': action_performed
        };
        response = await post(
          "http://47.107.117.59/fff/setTarget.php", //TODO
          body: data,
        );
        Map<String, dynamic> mapFromJson =
            json.decode(response.body.toString());
        print(response.body.toString());
        if (mapFromJson['status'] == 10000) {
          Navigator.pop(context);
          print('请求成功');
        }
      } on Error catch (e) {
        Faliure2();
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
              {
                print('11111');
                print('开始返回Scaffold');
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
                            Navigator.pop(context);
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
                                TextEditingController(text: plan_designed),
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
                          FlatButton(
                              color: Colors.grey,
                              onPressed: () {
                                EditGoal();
                              },
                              child: Text('完成'))
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
