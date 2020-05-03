import 'package:flutter/material.dart';
import 'pop_result.dart';

class NewGoalDirectionPageOne extends StatefulWidget {

  @override
  _NewGoalDirectionPageOneState createState() =>
      _NewGoalDirectionPageOneState();
}

class _NewGoalDirectionPageOneState extends State<NewGoalDirectionPageOne> {
        static final String pageName = "NewGoal1";

  List<bool> checkboxesForConsumptivePower = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新目标'),
        elevation: 0,
        leading: Container(),
        actions: <Widget>[
          IconButton(
            
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.of(context).pushNamed('NewGoal2').then((results) {
                  PopWithResults popResult = results as PopWithResults;
                  if (popResult != null) {
                    if (popResult.toPage == pageName) {
                      print(popResult.results.values.toList()[0]);
                    } else {
                      Navigator.of(context).pop(results);
                    }
                  };
                }
                );
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Text('请描述您的目标'),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: '无论目标大或小，请让您的目标符合你的核心价值，并具体的描述您的目标。',
                      style: TextStyle(
                          height: 1,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    TextSpan(
                      text:
                          '例如：“成为一个老师”比“改变这个世界”更为具体.',
                      style: TextStyle(
                          height: 1,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: '请不要将“目标”与“欲望”混淆。',
                      style: TextStyle(
                          height: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    TextSpan(
                      text:
                          '请确保您写下的目标符合您的核心价值实现。例如“获得好身材”是一个目标，而“吃好吃的垃圾食品”无益于目标的实现.',
                      style: TextStyle(
                          height: 1,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: '请不要按照“我觉得我可以达到”来限制您设定的目标.',
                      style: TextStyle(
                          height: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    TextSpan(
                      text: '，不要因为您未充分分析的障碍而限制你的目标实现。',
                      style: TextStyle(
                          height: 1,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: '目标',
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

