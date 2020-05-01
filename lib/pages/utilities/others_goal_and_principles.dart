import 'package:flutter/material.dart';
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
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: PrincipleCardScrollView(),
              ),
              Expanded(
              flex: 1,
              child: GoalAndObstaclesExtensionListView(),
              )
          ]
        ),
      ),
      //PrincipleCardScrollView(),
    );
  }
}
