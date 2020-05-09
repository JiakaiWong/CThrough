import 'package:date_matching/pages/widget_persontile_utility.dart';
import 'package:flutter/material.dart';

class FakeDiscoverGoal extends StatefulWidget {
  FakeDiscoverGoal({Key key}) : super(key: key);

  @override
  _FakeDiscoverGoalState createState() =>
      _FakeDiscoverGoalState();
}

class _FakeDiscoverGoalState
    extends State<FakeDiscoverGoal>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TheirPersonTileWithGoal(
              uuid: '7ab23f50-8e19-11ea-f37d-13590433e3bd',
              userIdentity: 'ETH',
              userName: '17届scut-CS-BS,class2020 UM-wisconsin',
              avatarId: 1,
              followed: 232,
              goal_setted: '去ZhengDong Su实验室',
              problems_identified: '需要年级排名top5%～top15%，TOFEL105，GRE score，实验室科研项目，有paper最好，实习经历、cs相关的比赛',
              root_causes_identified: '身边人似乎都没什么干劲，我老师觉得没有压力、造成各种效率下降',
              plan_designed: '在facebook结交了很多志同道合的朋友',
              action_performed:
                  '用5%的成绩排名和3篇论文成功获得ETHoffer',
            ),
          ),
        ],
      ),
    ));
  }
}
