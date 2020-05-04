import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

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

class NewGoal1Direction extends StatelessWidget {
  const NewGoal1Direction({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('请描述您的目标'),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: '无论目标大或小，请让您的目标符合你的核心价值，并具体的描述您的目标。',
                style: TextStyle(
                    height: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text: '例如：“成为一个老师”比“改变这个世界”更为具体.',
                style: TextStyle(
                    height: 1,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: '请不要将“目标”与“欲望”混淆。',
                style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text: '请确保您写下的目标符合您的核心价值实现。例如“获得好身材”是一个目标，而“吃好吃的垃圾食品”无益于目标的实现.',
                style: TextStyle(
                    height: 1,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: '请不要按照“我觉得我可以达到”来限制您设定的目标.',
                style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text: '，不要因为您未充分分析的障碍而限制你的目标实现。',
                style: TextStyle(
                    height: 1,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
