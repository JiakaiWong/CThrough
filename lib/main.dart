import 'package:flutter/material.dart';
import 'pages/page_edit_profile.dart';
import 'pages/page_new_principle.dart';

import 'pages/page_goal_dir_one.dart';
import 'pages/page_goal_dir_two.dart';
import 'pages/page_goal_dir_three.dart';
import 'pages/page_goal_dir_four.dart';
import 'pages/page_view_other_people.dart';
import 'pages/page_admin.dart';
import 'pages/page_add_tag.dart';


import 'pages/page_edit_goal.dart';
import 'pages/page_create_account.dart';
import 'bottom_navigation_widget.dart';
import 'pages/page_about_us.dart';
import 'pages/page_log_in.dart';
import 'pages/page_init.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: 'WelcomePage2',
      routes: {
        'Navigator': (context) => BottomNavigationWidget(), //底部导航栏
        'WelcomePage2': (context) => InitPageTwo(), //欢迎页面
        'AboutPage': (context) => AboutPage(), //关于我们
        'EditGoal': (context) => EditGoal(), //编辑目标
        'NewGoal1': (context) => NewGoalDirectionPageOne(), //新建目标
        'NewGoal2': (context) => NewGoalDirectionPageTwo(),
        'NewGoal3': (context) => NewGoalDirectionPageThree(),
        'NewGoal4': (context) => NewGoalDirectionPageFour(),
        'NewPrinciple': (context) => NewPrinciplePage(), //新建原则
        'LogIn': (context) => LoginPage(), //登陆
        'Register': (context) => CreateAccountPage(), //创建账号
        'EditProfileScreen': (context) => EditProfilePage(), //编辑用户资料
        'OtherPeopleDocumentPage': (context) =>
            OtherPeopleDocumentPage(), //查看其他用户
        'AdminPage': (context) => AdminPage(), //管理员模式
        'addTagPage': (context) => addTagPage(),
      },
      title: 'Flutter bottomNavigationBar',
      theme: ThemeData(
        //fontFamily: 'Cinzel',
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.black,
        backgroundColor: Colors.white,
        canvasColor: Colors.white,
      ),
      darkTheme: ThemeData(
        //fontFamily: 'PDI',
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
