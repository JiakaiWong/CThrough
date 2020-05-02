import 'package:flutter/material.dart';

class MyGoalsView extends StatefulWidget {
  @override
  _MyGoalsViewState createState() => _MyGoalsViewState();
}

class _MyGoalsViewState extends State<MyGoalsView> {
  @override
  Widget build(BuildContext context) {
    return FiveStepCardScrollView(
      goal_setted: '我的目标',
      problems_identified: '障碍',
      root_causes_identified: '原因',
      plan_designed: '某种计划',
      action_performed: '''我干了啥''',
    );
  }
}

//五步方法的基本模型
class BareFiveStep {
  BareFiveStep(
      {this.goal_setted,
      this.action_performed,
      this.plan_designed,
      this.problems_identified,
      this.root_causes_identified});
  String goal_setted;
  String problems_identified;
  String root_causes_identified;
  String plan_designed;
  String action_performed;
}

final List<BareFiveStep> demoData = <BareFiveStep>[
  BareFiveStep(
    goal_setted: 'demodata',
    problems_identified: '时间太少',
    root_causes_identified: '对完整性要求太高',
    plan_designed: '减少完整性、账户认证方面采用网易的api',
    action_performed: '取得初步成功',
  )
];

BareFiveStep oneDemoBareFiveStep = BareFiveStep(
  goal_setted: 'demodata',
  problems_identified: '时间太少',
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

class DemoPrincipleCardScrollView extends StatelessWidget {
  DemoPrincipleCardScrollView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        FiveStepCard(
          goal_setted: '想在五一期间把项目做个七七八八',
          problems_identified: '前后端之间接口不熟练，后端不能明确需求情况',
          root_causes_identified: '我之前学得少，也没有项目经验',
          plan_designed: '多花时间，',
          action_performed: '4月30号下午和5月1日全天都在做项目前端',
          ),
        FiveStepCard(
          goal_setted: '要高唱红歌',
          problems_identified: '没有时间唱',
          root_causes_identified: '不喜欢红歌',
          plan_designed: '多听红歌',
          action_performed: '听了很多红歌，认识到改革开放以来，中国大陆渐放开一些文艺管制，随着港澳台文化同西方文化开始涌入，大量流行歌曲进入中国大陆；且此时大陆民众的文化水平和认知能力逐渐提高，有些人开始对曾经的一些政策和运动产生反思，这对红色歌曲造成了一定的冲击。不过直到现在，中国政府依然实行言论控制，反映到歌曲上，要么不涉政治，要涉政治则必是红歌。因此，时至如今，中国大陆仍有部分人钟爱红歌。官方举办的大型文艺活动，红色歌曲也仍然是必不可少的节目；以至于一些来大陆发展的外国歌手，也通过表演红歌来获得大陆一些人的好感和认同。',
          ),
      ],
    );
  }
}
