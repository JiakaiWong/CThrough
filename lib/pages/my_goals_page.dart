import 'package:flutter/material.dart';
import 'utilities/my_goal_view.dart';



class MyGoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        // appBar: AppBar(
        //   title: Text('My goals and the obstacles'),
        //   elevation: 0,
        // ),
        body: FiveStepCardScrollView(
          goal_setted:'我的目标',
    problems_identified:'障碍',
    root_causes_identified:'原因',
    plan_designed:'某种计划',
    action_performed:'''我干了啥''',
          ),
        //GoalAndObstaclesExtensionListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(Text('clicked'));
            Navigator.pushNamed(context, 'NewGoal1');
            //Navigator.of(context).pushReplacementNamed('NewGoal1');
          },
          child: Text('添加'),
        ),
      ),
    );
  }
}

