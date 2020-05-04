import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class NewGoalDirectionPageThree extends StatefulWidget {
  @override
  _NewGoalDirectionPageThreeState createState() =>
      _NewGoalDirectionPageThreeState();
}

class _NewGoalDirectionPageThreeState extends State<NewGoalDirectionPageThree> {
  String uuid;
  String goal_setted;
  String problems_identified;
  String root_causes_identified;
  String plan_designed;
  String action_performed;
  void getCurrentGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //set uuid
    uuid = prefs.getString('currentGoal');
  }

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

  Future<Null> GetGoal() async {
    print('begin async');
    Response response;
    try {
      var data = {'uuid': uuid};
      response = await post(
        "http://47.107.117.59/fff/register.php", //TODO
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      print(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        goal_setted = mapFromJson['goal_setted'];
        problems_identified = mapFromJson['problems_identified'];
        root_causes_identified = mapFromJson['problems_identified'];
        plan_designed = mapFromJson['problems_identified'];
        action_performed = mapFromJson['problems_identified'];

        Navigator.pushReplacementNamed(context, 'NewGoal2');
        print('请求成功');
      }
    } on Error catch (e) {
      Faliure1();
    }
    return;
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
        "http://47.107.117.59/fff/register.php", //TODO
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      print(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        Navigator.pushReplacementNamed(context, 'NewGoal3');
        print('请求成功');
      }
    } on Error catch (e) {
      Faliure2();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: GetGoal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                leading: Container(),
                title: Text('障碍透视'),
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
                      NewGoal3Direction(),
                      TextField(
                        onChanged: (text) {
                          root_causes_identified = text;
                        },
                        decoration: InputDecoration(
                            hintText: '根本原因',
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
          } else if (snapshot.hasError) {
            return new Text('%{snapshot.hasError');
          }
          return Center(child: new CircularProgressIndicator());
        });
  }
}

class NewGoal3Direction extends StatelessWidget {
  const NewGoal3Direction({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: '请试着分析出造成障碍的根本原因',
                  style: TextStyle(
                    height: 2,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Theme.of(context).iconTheme.color,
                    decoration: TextDecoration.none,
                    decorationColor: Colors.red,
                    decorationStyle: TextDecorationStyle.wavy,
                  )),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: '分辨根本原因和直接原因很重要。',
                style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text:
                    '直接原因通常是造成障碍的行为或不作为，它们通常是某种行为。根本原因是直接原因的深层原因，通常是某种属性。例如“我没有做某件事，因为我是个常常忘记东西的人”',
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
                text: '根本原因不是行为，而是一种理论',
                style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text: '不停的问“为什么”，通常能帮助你找到根本原因',
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
