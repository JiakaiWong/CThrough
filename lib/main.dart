import 'package:flutter/material.dart';
import 'pages/sub_pages/edit_profile_screen.dart';
import 'pages/sub_pages/new_principle_page.dart';
import 'pages/goal_direction/goal_direction_page_one.dart';
import 'pages/goal_direction/goal_direction_page_two.dart';
import 'pages/goal_direction/goal_direction_page_three.dart';
import 'pages/goal_direction/goal_direction_page_four.dart';

import 'pages/utilities/others_goal_and_principles.dart';
import 'pages/sub_pages/register_page.dart';
import 'bottom_navigation_widget.dart';
import 'pages/sub_pages/about_us_page.dart';
import 'pages/sub_pages/log_in_page.dart';
import 'pages/sub_pages/change_password_page.dart';
import 'pages/utilities/view_following.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: 'LogIn',
      routes: {
        'Navigator': (context) => BottomNavigationWidget(),
        'EditProfileScreen': (context) => EditProfilePage(),
        'AboutPage': (context) => AboutPage(),
        'NewPrinciple': (context) => NewPrinciplePage(),
        'LogIn': (context) => LoginPage(),
        'NewGoal': (context) => NewGoalDirectionPageOne(),
        'NewGoal2': (context) => NewGoalDirectionPageTwo(),
        'NewGoal3': (context) => NewGoalDirectionPageThree(),
        'NewGoal4': (context) => NewGoalDirectionPageFour(),
        'PrincipleView': (context) => PrinciplePeak(),
                'PrincipleView2': (context) => PrinciplePeak2(),

        'Register': (context) => RegisterPage(),
        'ChangePassword': (context) => ChangePasswordPage(),
        'ViewFollowing': (context) => ViewFollowingPage(),
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
