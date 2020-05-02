import 'package:flutter/material.dart';

//两行字(最多四行)
class SmallPrincipleDescription extends StatelessWidget {
  SmallPrincipleDescription({
    Key key,
    this.principle_text,
    this.principle_description,
  }) : super(key: key); //constructor?
  final String principle_text;
  final String principle_description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$principle_text',
              textScaleFactor: 1.4,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text(
              '$principle_description',
              textScaleFactor: 1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//可以放很多行
class FullPrincipleDescription extends StatelessWidget {
  FullPrincipleDescription({
    Key key,
    this.principle_text,
    this.principle_description,
  }) : super(key: key); //constructor?
  final String principle_text;
  final String principle_description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$principle_text',
              textScaleFactor: 2.2,
              overflow: TextOverflow.ellipsis,
              maxLines: 100,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text(
              '$principle_description',
              textScaleFactor: 1.5,
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//给两行字加上圆角矩形
class PrincipleCard extends StatelessWidget {
  PrincipleCard({
    Key key,
    this.principle_text,
    this.principle_description,
  }) : super(key: key);
  final String principle_text;
  final String principle_description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            //color: Colors.grey,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child: SmallPrincipleDescription(
            principle_text: principle_text,
            principle_description: principle_description,
          ),
        ),
      ),
    );
  }
}
//可以变长的卡片
class FullPrincipleCard extends StatelessWidget {
  FullPrincipleCard({
    Key key,
    this.principle_text,
    this.principle_description,
  }) : super(key: key);
  final String principle_text;
  final String principle_description;
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
          child: FullPrincipleDescription(
            principle_text: principle_text,
            principle_description: principle_description,
          ),
        ),
      ),
    );
  }
}
//光光显示principle的
//不限制行数
class PrincipleCardScrollView extends StatelessWidget {
  PrincipleCardScrollView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        FullPrincipleCard(
          principle_text: '''使用First principles, 不要用analogy''',
          principle_description: 'from Elon Musk',
        ),
        FullPrincipleCard(
          principle_text: '观察客观世界了解事物运作的方式',
          principle_description: '不要拘泥于你所认为事物“应该”如何，因为这样会帮助你你会忘记事物的真相。要想“做好”，一个人必须持续按照自然规律行动',
        ),
        FullPrincipleCard(
          principle_text: '''进化是生命最伟大的成就和最丰厚的奖赏''',
          principle_description: '个人的目标必须与集体目标一致。客观世界总是趋向于整体优化，而不是个人。频繁的试错中获得的适应力是无价的。一个人总是既伟大又平凡，了解这一点，然后决定你想成为的样子。',
        ),
        FullPrincipleCard(
          principle_text: 'Follow principles',
          principle_description: 'from Ray Dalio',
        ),
        FullPrincipleCard(
          principle_text: '''使用First principles, 不要用analogy''',
          principle_description: 'from Elon Musk',
        ),
        FullPrincipleCard(
          principle_text: 'Follow principles',
          principle_description: 'from Ray Dalio',
        ),
      ],
    );
  }
}

//限制行数
class PrincipleCardScrollView2 extends StatelessWidget {
  PrincipleCardScrollView2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        PrincipleCard(
          principle_text: '成为超级现实主义的人',
          principle_description: '成功达到目标的人必须明白真实的因果关系，而理想主义者只创造问题，而不是推动进步。',
        ),
        PrincipleCard(
          principle_text: 'Follow principles',
          principle_description: 'from Ray Dalio',
        ),
      ],
    );
  }
}
