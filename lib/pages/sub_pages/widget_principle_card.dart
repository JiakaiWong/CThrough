import 'package:flutter/material.dart';
//https://javiercbk.github.io/json_to_dart/
//最基本的最重要的五步方法数据结构,包括从JSON到类和创建JSON
class BarePrincipleList {
  List<BarePrinciple> barePrinciple;

  BarePrincipleList({this.barePrinciple});

  BarePrincipleList.fromJson(Map<String, dynamic> json) {
    if (json['BarePrinciple'] != null) {
      barePrinciple = new List<BarePrinciple>();
      json['BarePrinciple'].forEach((v) {
        barePrinciple.add(new BarePrinciple.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.barePrinciple != null) {
      data['BarePrinciple'] =
          this.barePrinciple.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BarePrinciple {
  String uuid;
  String principleText;
  String principleDescription;

  BarePrinciple({this.uuid, this.principleText, this.principleDescription});

  BarePrinciple.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    principleText = json['principle_text'];
    principleDescription = json['principle_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['principle_text'] = this.principleText;
    data['principle_description'] = this.principleDescription;
    return data;
  }
}
//两行字(最多四行)
class SmallPrincipleDescription extends StatelessWidget {
  SmallPrincipleDescription({
    Key key,
    this.principleText,
    this.principleDescription,
  }) : super(key: key); 
  final String principleText;
  final String principleDescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$principleText',
              textScaleFactor: 1.4,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text(
              '$principleDescription',
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
    this.principleText,
    this.principleDescription,
  }) : super(key: key); 
  final String principleText;
  final String principleDescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$principleText',
              textScaleFactor: 2.2,
              overflow: TextOverflow.ellipsis,
              maxLines: 100,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text(
              '$principleDescription',
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
    this.principleText,
    this.principleDescription,
  }) : super(key: key); 
  final String principleText;
  final String principleDescription;  
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
    this.principleText,
    this.principleDescription,
  }) : super(key: key); 
  final String principleText;
  final String principleDescription; 
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
              principleText: principleText,
            principleDescription: principleDescription,          ),
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
    return Scaffold(
      body: ListView.builder(
          itemCount: null,
          // itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return FullPrincipleCard(
              
                  principleText: '这是第$index条原则',
                  principleDescription: '这是第$index条原则的介绍')
            ;
          }),
      floatingActionButton: FloatingActionButton.extended(
          label: Text('新的原则'),
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            Navigator.pushNamed(context, 'NewPrinciple');
          }),
    );
    // ListView(
    //   padding: const EdgeInsets.all(10.0),
    //   children: <Widget>[
    //     FullPrincipleCard(
    //       principleText: '''使用First principles, 不要用analogy''',
    //       principleDescription: 'from Elon Musk',
    //     ),
    //     FullPrincipleCard(
    //       principleText: '观察客观世界了解事物运作的方式',
    //       principleDescription: '不要拘泥于你所认为事物“应该”如何，因为这样会帮助你你会忘记事物的真相。要想“做好”，一个人必须持续按照自然规律行动',
    //     ),
    //     FullPrincipleCard(
    //       principleText: '''进化是生命最伟大的成就和最丰厚的奖赏''',
    //       principleDescription: '个人的目标必须与集体目标一致。客观世界总是趋向于整体优化，而不是个人。频繁的试错中获得的适应力是无价的。一个人总是既伟大又平凡，了解这一点，然后决定你想成为的样子。',
    //     ),
    //     FullPrincipleCard(
    //       principleText: 'Follow principles',
    //       principleDescription: 'from Ray Dalio',
    //     ),
    //     FullPrincipleCard(
    //       principleText: '''使用First principles, 不要用analogy''',
    //       principleDescription: 'from Elon Musk',
    //     ),
    //     FullPrincipleCard(
    //       principleText: 'Follow principles',
    //       principleDescription: 'from Ray Dalio',
    //     ),
    //   ],
    // );
  }
}

// //限制行数x
// class PrincipleCardScrollView2 extends StatelessWidget {
//   PrincipleCardScrollView2({Key key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(10.0),
//       children: <Widget>[
//         PrincipleCard(
//           principleText: '成为超级现实主义的人',
//           principleDescription: '成功达到目标的人必须明白真实的因果关系，而理想主义者只创造问题，而不是推动进步。',
//         ),
//         PrincipleCard(
//           principleText: 'Follow principles',
//           principleDescription: 'from Ray Dalio',
//         ),
//       ],
//     );
//   }
// }
