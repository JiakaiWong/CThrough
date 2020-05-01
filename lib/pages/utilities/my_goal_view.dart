// import 'dart:html';

import 'package:flutter/material.dart';


//五步方法的基本模型
class BareFiveStep {
  BareFiveStep({
    this.goal_setted,
    this.action_performed,
    this.plan_designed,
    this.problems_identified,
    this.root_causes_identified
  });
  String goal_setted;
  String problems_identified;
  String root_causes_identified;
  String plan_designed;
  String action_performed;
}

final List<BareFiveStep> demoData = <BareFiveStep>[
  BareFiveStep(
    goal_setted: 'demodata',
    problems_identified:'时间太少' ,
    root_causes_identified: '对完整性要求太高',
    plan_designed: '减少完整性、账户认证方面采用网易的api',
    action_performed: '取得初步成功',
    )
];

BareFiveStep oneDemoBareFiveStep = BareFiveStep(
    goal_setted: 'demodata',
    problems_identified:'时间太少' ,
    root_causes_identified: '对完整性要求太高',
    plan_designed: '减少完整性、账户认证方面采用网易的api',
    action_performed: '取得初步成功',
);



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
                      text: '$problems_identified',
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
                      text: '$root_causes_identified',
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
                      text: '$plan_designed',
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
                      text: '$action_performed',
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
                      child: FiveStep(
                        goal_setted: goal_setted,
                        problems_identified: (problems_identified == null ||
                                problems_identified == '')
                            ? '未识别障碍'
                            : problems_identified,
                        root_causes_identified:
                            (root_causes_identified == null ||
                                    root_causes_identified == '')
                                ? '未识别根本原因'
                                : root_causes_identified,
                        plan_designed:
                            (plan_designed == null || plan_designed == '')
                                ? '未编辑计划'
                                : plan_designed,
                        action_performed:
                            (action_performed == null || action_performed == '')
                                ? '未添加行为记录'
                                : action_performed,
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
    return 
    ListView(
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
