import 'package:flutter/material.dart';

class NewGoalDirectionPageOne extends StatefulWidget {
  @override
  _NewGoalDirectionPageOneState createState() =>
      _NewGoalDirectionPageOneState();
}

class _NewGoalDirectionPageOneState extends State<NewGoalDirectionPageOne> {
  List<bool> checkboxesForConsumptivePower = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Goal'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'NewGoal2');
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('请描述您的目标'),
                subtitle: Text('''
    无论目标大或小，请让您的目标符合你的核心价值，并具体的描述您的目标。例如：“成为一个老师”比“改变这个世界”更为具体.
    请不要将“目标”与“欲望”混淆，请确保您写下的目标符合您的核心价值实现。例如“获得好身材”是一个目标，而“吃好吃的垃圾食品”无益于目标的实现.
    请不要按照“我觉得我可以达到”来限制您设定的目标，不要因为您未充分分析的障碍而限制你的目标实现。
                    '''),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Goal',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                maxLength: 200,
                maxLines: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
