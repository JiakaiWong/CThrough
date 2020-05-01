import 'package:flutter/material.dart';

class NewGoalDirectionPageTwo extends StatefulWidget {
  @override
  _NewGoalDirectionPageTwoState createState() =>
      _NewGoalDirectionPageTwoState();
}

class _NewGoalDirectionPageTwoState extends State<NewGoalDirectionPageTwo> {
  List<bool> checkboxesForConsumptivePower = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('困难分析'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'NewGoal3');
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: '请描述实现目标的障碍',
                        style: TextStyle(
                          height: 2,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Theme.of(context).iconTheme.color,
                          decoration: TextDecoration.none,
                          decorationColor: Colors.red,
                          decorationStyle: TextDecorationStyle.wavy,
                        )),
                  ],
                ),
              ),
              Text('''
    那些最主要的阻碍您达到目标的障碍是什么？
                    '''),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: '请不要将问题和原因混淆。',
                      style: TextStyle(
                          height: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    TextSpan(
                      text:
                          '“我睡眠不足”不是一个障碍，它是其他障碍潜在的原因。为了帮助思考，请识别出未最佳化的结果。比如“我在工作中表现很差”。睡眠不足也许是这个问题的原因，或许原因也可以是别的什么。但为了识别出原因，您需要先准确识别出问题是什么。',
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
                      text: '当识别困难时，保持专注和有逻辑很重要。',
                      style: TextStyle(
                          height: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    TextSpan(
                      text:
                          '请在描述问题时保持精准，例如，说“人们不喜欢我”不如准确说出哪个人在何种情况下表现出了对你的不喜欢。',
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
                      text: '请留意“温水煮青蛙”现象.',
                      style: TextStyle(
                          height: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    TextSpan(
                      text: '人们很难避免逐渐习惯于不能接受的事物，当他们用清醒的意识分析时，这让他们大吃一惊。',
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
                    hintText: '障碍',
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
