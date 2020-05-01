import 'package:flutter/material.dart';
import 'pages/document_screen.dart';
import 'pages/discover_page.dart';
import 'pages/my_goals_page.dart';
import 'pages/my_principles_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
    static final String pageName = "Navigator";

  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 2;
  List<Widget> list = List();

  @override
  void initState() {
    list
      ..add(MyGoalsPage())
      ..add(MyPrinciplesScreen())
      ..add(DiscoverPage())
      ..add(DemoDocumentScreen());
    //..add(LoginPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: list[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0.0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.directions_run,
                ),
                title: Text(
                  '我的目标',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.folder_special,
                ),
                title: Text(
                  '我的原则',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.open_with,
                ),
                title: Text(
                  '发现',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                title: Text(
                  '我',
                )),
            //   BottomNavigationBarItem(
            //       icon: Icon(
            //         Icons.person,
            //       ),
            //       title: Text(
            //         'log in',
            //       )),
          ],
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.shifting,
        ),
      ),
    );
  }
}
