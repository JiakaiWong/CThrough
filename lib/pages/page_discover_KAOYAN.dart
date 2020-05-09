import 'package:date_matching/pages/widget_persontile_utility.dart';
import 'package:flutter/material.dart';

class FakeDiscoverKaoYan extends StatefulWidget {
  FakeDiscoverKaoYan({Key key}) : super(key: key);

  @override
  _FakeDiscoverKaoYanState createState() =>
      _FakeDiscoverKaoYanState();
}

class _FakeDiscoverKaoYanState
    extends State<FakeDiscoverKaoYan>
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
              userIdentity: 'NJU',
              userName: '17届XDU-CS-BS,class2023 NJU',
              avatarId: 2,
              followed: 123,
              goal_setted: '保LAMDA实验室',
              problems_identified: '高GPA，没有托福分数也要英语水平过关，实验室科研项目，有paper最好，实习经历、ACM最好能获奖',
              root_causes_identified: '感觉同时要做的事情太多了，压力有点大、计划完成度不够',
              plan_designed: '和目标一致的人一起努力',
              action_performed:
                  '用2%的成绩排名和3篇论文成功进LAMDA实验室',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TheirPersonTileWithGoal(
              uuid: '7ab23f50-8e19-11ea-f37d-13590433e3bd',
              userIdentity: 'SJTU',
              userName: '17届SCUT-CS-BS,class2023 THU',
              avatarId: 4,
              followed: 123,
              goal_setted: 'THU硕',
              problems_identified: '''成绩加权，清华要求前5%，有夏令营资格，1.GPA。至少处于全院前五，专业前三，全班第一的这个级别（当然每个学校每个班都会有所不同）但基本大同小异。这个没商量，对于一般人来说，这个进入清华的最基本的门槛。如果你是ACM能拿亚洲赛区金奖的编程奇才，或者有见义勇为，轰动全省的英雄事迹，当我没说。争取拿到国家奖学金及其他各类含金量较高的奖学金。
      2.竞赛。应当至少有一个国家级和数个省部级的学科竞赛的奖励，校奖也别嫌弃，多多益善。对于通信工程的同学来说，电赛是充实专业课知识最好的选择，也是含金量较高的比赛之一。当然，难度较大，耗时很长（至少准备一年以上，大佬除外），门槛较高。基础知识：数电，模电，单片机，c语言，电路……
如果有意向转软件或CS，可以花一两年时间啃啃《算法导论》，刷刷牛客网，leetcode，打打ACM，并深入学习CS培养方案里的一些知识。基本知识：数据结构，算法，编译原理，计算机网络，操作系统……以及CV，NLP等比较火爆的理论工具：各种语言的编译器，解释器，GITHUB，CSDN等各种开源库……此外，含金量较高的还有挑战杯，数模等，挑战杯最好省一以上，数模国赛最好能拿到国一，国二级别，美赛至少美一美二，如果能拿到O奖，F奖这一级别，可能全校的人要来跪舔你，至少我们学校是这样2333。然后就是互联网+，TI杯，大创，FPGA设计大赛之类的比赛，多水一水，多参加，有收益。
3.科研经历当你具备一定实力，比如数理逻辑，编程，英文论文之类的实力之后，就去你们学院找找导师做做项目，发发核心期刊的论文，SCI，EI……记得我们学院有一位保研清华的学姐本科发了篇SCI，被国外某知名大学聘请到那个国家去做了一场专题讲座，伏地膜orz。还有一位学长，GPA一直是专业第一，找到了某国院士做科研，本科就发了一篇机器学习的顶会论文。一般老师不会给本科生安排太难的任务的，就当是积攒一些经历，为研究生生活做准备了。4.英语四级600以上/六级550以上，清华对这个比较佛系，过了就行，身边有两个保研清华的学长六级都是压线过，但前提是你其他方面得特别优秀。雅思7.5以上/托福110以上，不是硬性要求，但有比没有好。如果英语不是特别强，雅思6.5+/托福90+也行。5.学生工作参加一些科技社团和科技类的学生组织，争取做到管理层，这会锻炼你的管理能力，会结交很多技术，学术方面的大佬，一起做竞赛会很占优势，还可以向大佬多学习，多交流。如果有在中科院，高校等地的实习机会也可以事先知道，如果足够优秀还可以评一些优秀学生干部之类的，增加荣誉头衔。6.志愿活动对于励志保研的通信工程的学生来说，此项主要是帮老师管实验室，开展一些学习和技术的讲座，带学弟做项目之类的。身边还有个保研清华的学长，大学三年技术类的讲座开了大大小小上千余次，管理着十几个实验室。
              ''',
              root_causes_identified: '感觉同时要做的事情太多了，压力有点大、计划完成度不够',
              plan_designed: '和目标一致的人一起努力',
              action_performed:
                  '用2%的成绩排名和3篇论文成功进LAMDA实验室',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TheirPersonTileWithGoal(
              uuid: '7ab23f50-8e19-11ea-f37d-13590433e3bd',
              userIdentity: 'THU',
              userName: '17届XDU-CS-BS,class2023 NJU',
              avatarId: 6,
              followed: 123,
              goal_setted: '保LAMDA实验室',
              problems_identified: '高GPA，没有托福分数也要英语水平过关，实验室科研项目，有paper最好，实习经历、ACM最好能获奖',
              root_causes_identified: '感觉同时要做的事情太多了，压力有点大、计划完成度不够',
              plan_designed: '和目标一致的人一起努力',
              action_performed:
                  '用2%的成绩排名和3篇论文成功进LAMDA实验室',
            ),
          ),
        ],
      ),
    ));
  }
}
