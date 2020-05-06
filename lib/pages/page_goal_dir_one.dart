import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'widget_edit_goal_utility.dart';
class NewGoalDirectionPageOne extends StatefulWidget {
  @override
  _NewGoalDirectionPageOneState createState() =>
      _NewGoalDirectionPageOneState();
}

class _NewGoalDirectionPageOneState extends State<NewGoalDirectionPageOne> {
  Widget futureWidget() {
    String goal_setted = '';
    String problems_identified = '';
    String root_causes_identified = '';
    String plan_designed = '';
    String action_performed = '';
    final tuid = Uuid().v1();
    var uuid;
    //get uuid from local shared_preference
    Future<String> getUuid() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      uuid = prefs.getString('uuid');
      return uuid;
    }

    changeCurrentGoal() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('currentGoal', "$tuid");
    }

    changeCurrentGoalSetted() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('currentGoalSetted', "$goal_setted");
    }


    void getCurrentGoalSetted() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      goal_setted = prefs.getString('currentGoalSetted');
    }
    void getCurrentProblemsIdentified() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      problems_identified = prefs.getString('currentProblemsIdentified');
    }
    void getCurrentRootCausesIdentified() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      root_causes_identified = prefs.getString('currentRootCausesIdentified');
    }
    void getCurrentPlanDesigned() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      plan_designed = prefs.getString('currentPlanDesigned');
    }
    void getCurrentActionPerformed() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      action_performed = prefs.getString('currentActionPerformed');
    }
//init
    Future<String> getThingsDone() async {
      getUuid();
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

    Future<Null> EditGoal() async {
      print('开始第一部分的传输');
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
        print(data);
        response = await post(
          "http://47.107.117.59/fff/setTarget.php", //TODO
          body: data,
        );

        print('response got');
        Map<String, dynamic> mapFromJson =
            json.decode(response.body.toString());
        print(response.body.toString());
        if (mapFromJson['status'] == 10000) {
          print('新建目标成功');

          changeCurrentGoalSetted();
          Navigator.pushReplacementNamed(context, 'NewGoal2');
          print('请求成功');
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
                    leading: Container(),
                    title: Text('请描述您的目标'),
                    elevation: 0,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          EditGoal();
                        },
                      )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: ListView(
                        children: <Widget>[
                          NewGoal1Direction(),
                          TextField(
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

