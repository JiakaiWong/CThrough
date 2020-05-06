import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget_edit_goal_utility.dart';

class MyGoalPage extends StatefulWidget {
  MyGoalPage({Key key}) : super(key: key);

  @override
  _MyGoalPageState createState() => _MyGoalPageState();
}

class _MyGoalPageState extends State<MyGoalPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<bool> Failure() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('出错'),
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
    print(myuuid);
    return myuuid;
  }

  Future<int> GetMyGoalData() async {
    var myuuid = await getUuid();
    print('begin GetMyGoalData');
    Response response;
    try {
      var data = {'uuid': myuuid};

      response = await post(
        "http://47.107.117.59/fff/getTargets.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      listOfBareFiveStep.removeRange(0, listOfBareFiveStep.length);

      if (mapFromJson['status'] == 10000) {
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfBareFiveStep.add(BareFiveStep(
            goal_setted: '默认目标',
            problems_identified: ' ',
            root_causes_identified: ' ',
            plan_designed: ' ',
            action_performed: ' ',
          ));
        }
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfBareFiveStep[i].uuid = mapFromJson['results'][i]['tuid'];
          listOfBareFiveStep[i].problems_identified =
              mapFromJson['results'][i]['problem'];
          listOfBareFiveStep[i].root_causes_identified =
              mapFromJson['results'][i]['reason'];
          listOfBareFiveStep[i].goal_setted = mapFromJson['results'][i]['goal'];
          listOfBareFiveStep[i].plan_designed =
              mapFromJson['results'][i]['plan'];
          listOfBareFiveStep[i].action_performed =
              mapFromJson['results'][i]['action'];
        }
        print('我的目标列表存储结束,长度为：');
        print(listOfBareFiveStep.length);
      } else if (mapFromJson['status'] == 20000) {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');

      Failure();
    }
    return listOfBareFiveStep.length;
  }

  Future DeleteGoal(String tuid) async {
    print('开始删除目标');
    Response response;
    try {
      var data = {'tuid': tuid};
      response = await post(
        "http://47.107.117.59/fff/deleteTarget.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      if (mapFromJson['status'] == 10000) {
        print('删除成功');
      } else if (mapFromJson['status'] == 20000) {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');
      Failure();
    }
  }

  Widget futureWidget() {
    return new FutureBuilder(
        future: GetMyGoalData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('未请求');
            case ConnectionState.waiting:
              {
                return new Text('Awaiting result...');
              } 
            default: 
              if (snapshot.hasError) {
                print('snapshot.hasError');
                return new Text('Error: ${snapshot.error}');
              } 
              else {
                return new Scaffold(
                  body: new ListView.builder(
                      itemCount: snapshot.data,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Dismissible(
                            key: Key('keyOfFiveStepCard$index'),
                            onDismissed: (direction) {
                              var _snackStr = '删除了一个目标';
                              if (direction == DismissDirection.endToStart) {
                                // 从右向左
                                _snackStr = '从右向左删除了目标';
                              } else if (direction ==
                                  DismissDirection.startToEnd) {
                                _snackStr = '从左向右删除了目标';
                              }
                              DeleteGoal(listOfBareFiveStep[index].uuid);
                              // 展示 SnackBar
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(_snackStr),
                              ));
                              setState(() {});
                            },
                            background: Container(
                              color: Colors.red,
                              child: ListTile(
                                leading: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                trailing: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.blue,
                              child: ListTile(
                                title: Text(
                                  '            你是删不掉我的',
                                  textScaleFactor: 2.0,
                                ),
                                trailing: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: FiveStepCard(
                              uuid: listOfBareFiveStep[index].uuid,
                              goal_setted:
                                  listOfBareFiveStep[index].goal_setted,
                              problems_identified:
                                  listOfBareFiveStep[index].problems_identified,
                              root_causes_identified: listOfBareFiveStep[index]
                                  .root_causes_identified,
                              plan_designed:
                                  listOfBareFiveStep[index].plan_designed,
                              action_performed:
                                  listOfBareFiveStep[index].action_performed,
                            ),
                          ),
                        );
                      }),
                  floatingActionButton: FloatingActionButton.extended(
                      label: Text('新的目标'),
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        Navigator.pushNamed(context, 'NewGoal1');
                      }),
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

//最基本的最重要的五步方法数据结构
class BareFiveStep {
  BareFiveStep(
      {this.uuid = '',
      this.goal_setted = '',
      this.action_performed = '',
      this.plan_designed = '',
      this.problems_identified = '',
      this.root_causes_identified = ''});
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
                      text: (goal_setted == null || goal_setted == '')
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
  Future<Null> changeCurrentGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentGoal', "$uuid");
  }

  FiveStepCard({
    Key key,
    this.uuid,
    this.goal_setted,
    this.problems_identified,
    this.root_causes_identified,
    this.plan_designed,
    this.action_performed,
  }) : super(key: key);
  final String uuid;
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
            print('开始设置目标');
            changeCurrentGoal().then((response) {
              Navigator.pushNamed(context, 'EditGoal');
            }).then((response) {
              print('跳转');
            });
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
