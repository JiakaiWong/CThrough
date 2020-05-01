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
              textScaleFactor: 2.2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle( 
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text(
              '$principle_description',
              textScaleFactor: 1.5,
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
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$principle_text',
                textScaleFactor: 2.2,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle( 
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$principle_description',
                textScaleFactor: 1.5,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                child: SmallPrincipleDescription(
                  principle_text: principle_text,
                  principle_description: principle_description,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
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
      child: SizedBox(
        height: 300,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: FullPrincipleDescription(
                  principle_text: principle_text,
                  principle_description: principle_description,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PrincipleCardScrollView extends StatelessWidget {
  PrincipleCardScrollView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        PrincipleCard(
          principle_text: '使用First principles, 不要用analogy',
          principle_description: 'from Elon Musk',
        ),
        PrincipleCard(
          principle_text: 'Follow principles',
          principle_description: 'from Ray Dalio',
        ),
      ],
    );
  }
}

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