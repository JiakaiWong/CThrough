import 'package:flutter/material.dart';
import 'my_goal_view.dart';
import 'principle_card.dart';
import 'goal&obstacle_ExpansionTile.dart';

class PrinciplePeak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ta 的原则'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(children: <Widget>[
          Expanded(
            flex: 1,
            child: PrincipleCardScrollView(),
          ),
          Expanded(
            flex: 1,
            child: GoalAndObstaclesExtensionListView(),
          )
        ]),
      ),
      //PrincipleCardScrollView(),
    );
  }
}

class PrinciplePeak2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ta 的原则'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: ListView(
          children: <Widget>[
          FullPrincipleCard(
            principle_text: '成为超级现实主义的人',
            principle_description: '成功达到目标的人必须明白真实的因果关系，而理想主义者只创造问题，而不是推动进步。',
          ),
          FiveStepCard(
            goal_setted: '在4天内上线一个程序',
            problems_identified: '时间太少',
            root_causes_identified: '对完整性要求太高',
            plan_designed: '减少完整性、账户认证方面采用网易的api',
            action_performed: '取得初步成功',
          ),
        ]),
      ),
      //PrincipleCardScrollView(),
    );
  }
}
