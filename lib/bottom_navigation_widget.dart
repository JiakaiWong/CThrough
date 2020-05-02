import 'package:flutter/material.dart';
import 'pages/document_screen.dart';
import 'pages/sub_pages/page_discover.dart';
import 'pages/my_goals&principles.dart';

class BottomNavigationWidget extends StatefulWidget {
    static final String pageName = "Navigator";

  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 1;
  List<Widget> list = List();

Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  void initState() {
    list
      ..add(MyGoalsAndPrinciplesPage())
      ..add(DiscoverPage())
      ..add(DocumentScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: list[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).accentColor,
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
            '我的目标原则',
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
            '个人资料',
          )),
      
            ],
            currentIndex: _currentIndex,
            onTap: (int index) {
      setState(() {
        _currentIndex = index;
      });
            },
            type: BottomNavigationBarType.fixed,
          ),
        ),
    );
  }
}
