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
        body: FiveStepCardScrollView(),
        //GoalAndObstaclesExtensionListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
              .pushReplacementNamed('NewGoal');
          },
          child: Text('添加'),
        ),
      ),
    );
  }
}

