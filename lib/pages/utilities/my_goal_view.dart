// import 'dart:html';

import 'package:flutter/material.dart';

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: '$goal_setted',
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
                          text: '$problems_identified',
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
                          text: '$root_causes_identified',
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
                          text: '$plan_designed',
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
                          text: '$action_performed',
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
              ],
            ),
          ],
        ),
      ],
    );
  }
}

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
      child: Card(
        child: new InkWell(
          onTap: () {
            Navigator.pushNamed(context, '');
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 400,
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
                              : plan_designed,
                          root_causes_identified:
                              (root_causes_identified == null ||
                                      root_causes_identified == '')
                                  ? '未识别根本原因'
                                  : plan_designed,
                          plan_designed:
                              (plan_designed == null || plan_designed == '')
                                  ? '未编辑计划'
                                  : plan_designed,
                          action_performed: (action_performed == null ||
                                  action_performed == '')
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
      ),
    );
  }
}

class FiveStepCardScrollView extends StatelessWidget {
  FiveStepCardScrollView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        FiveStepCard(
          goal_setted: '程序竞赛进决赛',
          problems_identified: '就要豪迈',
          root_causes_identified: '北大教授王铁崖',
          plan_designed: '11',
          action_performed: '',
        ),
      ],
    );
  }
}
