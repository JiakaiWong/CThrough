import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyGoalPage extends StatefulWidget {
  MyGoalPage({Key key}) : super(key: key);
  @override
  _MyGoalPageState createState() => _MyGoalPageState();
}

class _MyGoalPageState extends State<MyGoalPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<bool> Faliure() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('无法获取个人信息'),
            content: new Text('请稍后再试'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  //get uuid from local shared_preference
  Future<String> getUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var myuuid = prefs.getString('uuid');
    return myuuid;
  }

  Future<Null> GetMyGoalData() async {
    var myuuid = await getUuid();
    print('begin GetMyGoalData');
    print(myuuid);
    Response response;
    try {
      var data = {'uuid': myuuid};
      
      response = await post(
        "http://47.107.117.59/fff/getTargets.php",
        body: data,
      );
      print('body: [${response.body}]');
      Map<String, dynamic> mapFromJson = json.decode(response.body);
      print(mapFromJson);
      // print(data);
      // print(personTileData.uuid);
      // if (mapFromJson['status'] == 10000) {
      //   print('请求成功');
      //   personTileData.avatarId = mapFromJson['avartarId'];
      //   personTileData.followed = mapFromJson['followed'];
      //   personTileData.userIdentity = mapFromJson['identity'];
      //   personTileData.userName = mapFromJson['nick'];
      //   print(personTileData.avatarId);
      //   print(personTileData.userName);
      // } else if (mapFromJson['status'] == 20000) {
      //   Scaffold.of(context).showSnackBar(new SnackBar(
      //     content: new Text("请求失败"),
      //     action: new SnackBarAction(
      //       label: "OK",
      //       onPressed: () {},
      //     ),
      //   ));
      // }
    } on Error catch (e) {
      print(e);
      Faliure();
    }
    return;
  }

  Widget futureWidget() {
    return new FutureBuilder(
        future: GetMyGoalData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text(
                  'Press button to start'); //如果_calculation未执行则提示：请点击开始
            case ConnectionState.waiting:
              return new Text('Awaiting result...'); //如果_calculation正在执行则提示：加载中
            default: //如果_calculation执行完毕
              if (snapshot.hasError) //若_calculation执行出现异常
                return new Text('Error: ${snapshot.error}');
              else //若_calculation执行正常完成
                return new Scaffold(
                  body: ListView.builder(
                      itemCount: null,
                      // itemExtent: 50.0, //强制高度为50.0
                      itemBuilder: (BuildContext context, int index) {
                        return FiveStepCard(
                          goal_setted: '',
                          problems_identified: '别看了，这个功能还没实现。',
                          root_causes_identified: '',
                          plan_designed: '',
                          action_performed: '',
                        );
                      }),
                  floatingActionButton: FloatingActionButton.extended(
                      label: Text('新的目标'),
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        //TODO:

                        Navigator.pushNamed(context, 'NewGoal1');
                      }),
                );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return futureWidget();
  }
}

Future<String> NewGoalRequest() async {
  return await ('http://47.107.117.59/fff/set_target.php');
}

//最基本的最重要的五步方法数据结构
class BareFiveStep {
  BareFiveStep(
      {this.uuid,
      this.goal_setted,
      this.action_performed,
      this.plan_designed,
      this.problems_identified,
      this.root_causes_identified});
  String uuid;
  String goal_setted;
  String problems_identified;
  String root_causes_identified;
  String plan_designed;
  String action_performed;
}

//用不同大小显示5行字
class FiveStep extends StatelessWidget {
  FiveStep({
    Key key,
    this.goal_setted,
    this.problems_identified,
    this.root_causes_identified,
    this.plan_designed,
    this.action_performed,
  }) : super(key: key); //constructor?

  final String goal_setted;
  final String problems_identified;
  final String root_causes_identified;
  final String plan_designed;
  final String action_performed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text('目标'),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: '$goal_setted',
                      style: TextStyle(
                        height: 1.1,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                        decorationColor: Colors.red,
                        decorationStyle: TextDecorationStyle.wavy,
                      )),
                ],
              ),
            ),
            Text('障碍'),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: (problems_identified == null ||
                              problems_identified == '')
                          ? '未识别障碍'
                          : '$problems_identified',
                      style: TextStyle(
                        height: 1.1,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                        decorationColor: Colors.red,
                        decorationStyle: TextDecorationStyle.wavy,
                      )),
                ],
              ),
            ),
            Text('原因'),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: (root_causes_identified == null ||
                              root_causes_identified == '')
                          ? '未识别根本原因'
                          : '$root_causes_identified',
                      style: TextStyle(
                        height: 1.1,
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
            Text('计划'),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: (plan_designed == null || plan_designed == '')
                          ? '未编辑计划'
                          : '$plan_designed',
                      style: TextStyle(
                        height: 1.1,
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
            Text('执行情况'),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: (action_performed == null || action_performed == '')
                          ? '未添加行为记录'
                          : '$action_performed',
                      style: TextStyle(
                        height: 2,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                        decorationColor: Colors.red,
                        decorationStyle: TextDecorationStyle.wavy,
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//用不同大小显示5行字
class MiniFiveStep extends StatelessWidget {
  MiniFiveStep({
    Key key,
    this.goal_setted,
    this.problems_identified,
    this.root_causes_identified,
    this.plan_designed,
    this.action_performed,
  }) : super(key: key); //constructor?

  final String goal_setted;
  final String problems_identified;
  final String root_causes_identified;
  final String plan_designed;
  final String action_performed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: '目标:',
                      style: TextStyle(
                        height: 1.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                      )),
                  TextSpan(
                      text: (problems_identified == null ||
                              problems_identified == '')
                          ? '未设定目标'
                          : '$goal_setted',
                      style: TextStyle(
                        height: 1.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                      )),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: '障碍:',
                      style: TextStyle(
                        height: 1.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                      )),
                  TextSpan(
                      text: (problems_identified == null ||
                              problems_identified == '')
                          ? '未识别障碍'
                          : '$problems_identified',
                      style: TextStyle(
                        height: 1.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                      )),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: '障碍:',
                      style: TextStyle(
                        height: 1.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                      )),
                  TextSpan(
                      text: (root_causes_identified == null ||
                              root_causes_identified == '')
                          ? '根本原因：'
                          : '$root_causes_identified',
                      style: TextStyle(
                        height: 1.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                      )),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: '计划:',
                      style: TextStyle(
                        height: 1.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                      )),
                  TextSpan(
                      text: (plan_designed == null || plan_designed == '')
                          ? '未编辑计划'
                          : '$plan_designed',
                      style: TextStyle(
                        height: 1.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                      )),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: '执行:',
                      style: TextStyle(
                        height: 1.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                      )),
                  TextSpan(
                      text: (action_performed == null || action_performed == '')
                          ? '未添加行为记录'
                          : '$action_performed',
                      style: TextStyle(
                        height: 1.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).iconTheme.color,
                        decoration: TextDecoration.none,
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//放进圆角矩形里
class FiveStepCard extends StatelessWidget {
  FiveStepCard({
    Key key,
    this.goal_setted,
    this.problems_identified,
    this.root_causes_identified,
    this.plan_designed,
    this.action_performed,
  }) : super(key: key);
  final String goal_setted;
  final String problems_identified;
  final String root_causes_identified;
  final String plan_designed;
  final String action_performed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'EditGoal');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                      child: MiniFiveStep(
                        goal_setted: goal_setted,
                        problems_identified: problems_identified,
                        root_causes_identified: root_causes_identified,
                        plan_designed: plan_designed,
                        action_performed: action_performed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//这是一个stateful widget
class FiveStepCardScrollView extends StatelessWidget {
  FiveStepCardScrollView({
    Key key,
    this.goal_setted,
    this.problems_identified,
    this.root_causes_identified,
    this.plan_designed,
    this.action_performed,
  }) : super(key: key); //constructor?

  final String goal_setted;
  final String problems_identified;
  final String root_causes_identified;
  final String plan_designed;
  final String action_performed;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        FiveStepCard(
          goal_setted: goal_setted,
          problems_identified: problems_identified,
          root_causes_identified: root_causes_identified,
          plan_designed: plan_designed,
          action_performed: action_performed,
        ),
      ],
    );
  }
}
