import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class NewGoalDirectionPageTwo extends StatefulWidget {
  @override
  _NewGoalDirectionPageTwoState createState() =>
      _NewGoalDirectionPageTwoState();
}

class _NewGoalDirectionPageTwoState extends State<NewGoalDirectionPageTwo> {
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
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('障碍识别'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              NewGoal2Column(),
              TextField(
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
  }
}

class NewGoal2Column extends StatelessWidget {
  const NewGoal2Column({
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
                  text: '请描述实现目标的障碍',
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
    那些最主要的阻碍您达到目标的障碍是什么？
          '''),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: '请不要将问题和原因混淆。',
                style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text:
                    '“我睡眠不足”不是一个障碍，它是其他障碍潜在的原因。为了帮助思考，请识别出未最佳化的结果。比如“我在工作中表现很差”。睡眠不足也许是这个问题的原因，或许原因也可以是别的什么。但为了识别出原因，您需要先准确识别出问题是什么。',
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
                text: '当识别困难时，保持专注和有逻辑很重要。',
                style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text: '请在描述问题时保持精准，例如，说“人们不喜欢我”不如准确说出哪个人在何种情况下表现出了对你的不喜欢。',
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
                text: '请留意“温水煮青蛙”现象.',
                style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).iconTheme.color),
              ),
              TextSpan(
                text: '人们很难避免逐渐习惯于不能接受的事物，当他们用清醒的意识分析时，这让他们大吃一惊。',
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
