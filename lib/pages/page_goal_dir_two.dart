import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget_edit_goal_utility.dart';

class NewGoalDirectionPageTwo extends StatefulWidget {
  @override
  _NewGoalDirectionPageTwoState createState() =>
      _NewGoalDirectionPageTwoState();
}

class _NewGoalDirectionPageTwoState extends State<NewGoalDirectionPageTwo> {
  Widget futureWidget() {
    String goal_setted = '';
    String problems_identified = '';
    String root_causes_identified = '';
    String plan_designed = '';
    String action_performed = '';
    var uuid;
    var tuid;

    //get uuid from local shared_preference
    Future<String> getUuid() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      uuid = prefs.getString('uuid');
      return uuid;
    }

    void getCurrentGoal() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set tuid
      tuid = prefs.getString('currentGoal');
    }

    changeCurrentProblemsIdentified() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('currentProblemsIdentified', "$problems_identified");
    }

    void getCurrentGoalSetted() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      goal_setted = prefs.getString('currentGoalSetted');
    }

    Future<String> getThingsDone() async {
      getUuid();
      getCurrentGoal();
      getCurrentGoalSetted();
    }

    Future<bool> Failure1() async {
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
      getCurrentGoalSetted();
      getCurrentGoal();
      print('begin sending');
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
          changeCurrentProblemsIdentified();
          print('目标设置成功');

          Navigator.pushReplacementNamed(context, 'NewGoal3');
        }
      } on Error catch (e) {
        print(e);
        Failure2();
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
                    title: Text('障碍识别'),
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
                          NewGoal2Direction(),
                          TextField(
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
