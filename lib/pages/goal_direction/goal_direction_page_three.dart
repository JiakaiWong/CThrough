import 'package:flutter/material.dart';

class NewGoalDirectionPageThree extends StatefulWidget {
  @override
  _NewGoalDirectionPageThreeState createState() =>
      _NewGoalDirectionPageThreeState();
}

class _NewGoalDirectionPageThreeState extends State<NewGoalDirectionPageThree> {
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
                Navigator.pushReplacementNamed(context, 'NewGoal4');
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
                        text: '请试着分析出造成障碍的根本原因',
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
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: '分辨根本原因和直接原因很重要。',
                      style: TextStyle(
                          height: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    TextSpan(
                      text:
                          '直接原因通常是造成障碍的行为或不作为，它们通常是某种行为。根本原因是直接原因的深层原因，通常是某种属性。例如“我没有做某件事，因为我是个常常忘记东西的人”',
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
                      text: '根本原因不是行为，而是一种理论',
                      style: TextStyle(
                          height: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    TextSpan(
                      text:
                          '不停的问“为什么”，通常能帮助你找到根本原因',
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
                    hintText: '根本原因',
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
