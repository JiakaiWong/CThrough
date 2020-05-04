import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewGoalDirectionPageFour extends StatefulWidget {
  @override
  _NewGoalDirectionPageFourState createState() =>
      _NewGoalDirectionPageFourState();
}

class _NewGoalDirectionPageFourState extends State<NewGoalDirectionPageFour> {
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
        Navigator.popUntil(context, ModalRoute.withName('Navigator'));
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
                          plan_designed = text;
                        },
                        decoration: InputDecoration(
                            hintText: '障碍',
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

class NewGoal2Direction extends StatelessWidget {
  const NewGoal2Direction({
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
                  text: '请思考造成障碍的根本原因并设计一个解决问题的方案。',
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
        Text('''
    请确保计划针对那些根本原因。
          '''),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: '计划可以又笼统到具体',
                style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text:
                    '例如：“获得名校硕士学位”，之后改良计划，添加具体的任务和预估的时间线。例如“在接下来的两周里，整理一些想要申请的学校，并且记录下他们的截止日期。”',
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
                text: '像写电影剧本那样制定计划。',
                style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text: '当你想象谁在什么时间会做什么以便完成你的计划。当制定你的计划时，思考不同相互关联的事件如何在时间线上连结到一起。',
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
                text: '认识设计计划是一个反复迭代的过程。',
                style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text: '在“坏的”现在和“好的”未来之间，是一段实现目标的过程。这段过程中你将会尝试不同的做法，与不同的人打交道，反复试错、在迭代中学习、最终实现设计的结局。错误的尝试是不可避免的。',
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
