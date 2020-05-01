import 'package:flutter/material.dart';

class _PrincipleDescription extends StatelessWidget {
  _PrincipleDescription({
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
                maxLines: 1,
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
      child: SizedBox(
        height: 130,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // AspectRatio(
            //   aspectRatio: 0.75,
            //   child: thumbnail,
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _PrincipleDescription(
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