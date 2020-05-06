import 'package:flutter/material.dart';
import 'pages/page_edit_profile.dart';
import 'pages/page_new_principle.dart';

import 'pages/page_goal_dir_one.dart';
import 'pages/page_goal_dir_two.dart';
import 'pages/page_goal_dir_three.dart';
import 'pages/page_goal_dir_four.dart';

import 'pages/page_edit_goal.dart';
import 'pages/page_create_account.dart';
import 'bottom_navigation_widget.dart';
import 'pages/page_about_us.dart';
import 'pages/page_log_in.dart';
import 'pages/init_direction_two.dart';

// void main() {
//   final myProfileNotifier = ProfileNotifier();
//   var myNameAndMessage = NameAndMessage(
//     '默认用户名',
//     '',
//     'To understand the world',
//     'To impact the world',
//     'To learn/evolve',
//   );
  
//   runApp(
//     Provider<NameAndMessage>.value(
//       value: myNameAndMessage,
//       child: ChangeNotifierProvider.value(
//         value: myProfileNotifier,
//         child: MyApp(),
//       ),
//     ),
//   );
// }


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: 'WelcomPage2',
      routes: {
        'Navigator': (context) => BottomNavigationWidget(),
        'WelcomePage2': (context) => InitPageTwo(),
        'AboutPage': (context) => AboutPage(),
        'NewGoal1': (context) => NewGoalDirectionPageOne(),
        'NewGoal2': (context) => NewGoalDirectionPageTwo(),
        'NewGoal3': (context) => NewGoalDirectionPageThree(),
        'NewGoal4': (context) => NewGoalDirectionPageFour(),
        'NewPrinciple': (context) => NewPrinciplePage(),
        'LogIn': (context) => LoginPage(),
        'EditGoal': (context) => EditGoal(),
        
        'Register': (context) => CreateAccountPage(),
        
        'EditProfileScreen': (context) => EditProfilePage(),

      },
      title: 'Flutter bottomNavigationBar',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.black,
        backgroundColor: Colors.white,
        canvasColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
        backgroundColor: Colors.black,
        canvasColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      home: BottomNavigationWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
