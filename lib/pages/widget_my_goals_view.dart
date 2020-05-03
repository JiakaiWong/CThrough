import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

class MyGoalPage extends StatefulWidget {
  MyGoalPage({Key key}) : super(key: key);
  @override
  _MyGoalPageState createState() => _MyGoalPageState();
}

class _MyGoalPageState extends State<MyGoalPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: null,
          // itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return FiveStepCard(
              goal_setted: Uuid().v4(),
              problems_identified: '这是实现第$index个目标遇到的问题',
              root_causes_identified: '这是实现第$index个目标遇到的问题背后的根本原因',
              plan_designed: '这是为了克服第$index个目标遇到的问题所制定的计划',
              action_performed: '这是为了克服第$index个目标遇到的问题所制定的计划的完成情况',
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
}
Future<String> NewGoalRequest() async {
  return await ('http://47.107.117.59/fff/set_target.php');
}