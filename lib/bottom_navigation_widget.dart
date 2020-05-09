import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/page_document_screen.dart';
import 'pages/page_discover.dart';
import 'pages/my_goals&principles.dart';

class BottomNavigationWidget extends StatefulWidget {
  static final String pageName = "Navigator";

  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  PageController _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String title;
  String content;
  String time;
  String uuid;

//用shared_preference存储uuid
  setTime(String time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('NotificationTime', time);
  }

//登陆操作
  Future<Null> GetNotificatinon() async {
    Response response;
    try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
    String prevTime = prefs.getString('NotificationTime');
      response = await post("http://47.107.117.59/fff/getNotice.php");
      Map<String, dynamic> mapFromJson = json.decode(response.body);
      if (mapFromJson['status'] == 10000) {
        uuid = mapFromJson['uuid'];
        title = mapFromJson['title'];
        content = mapFromJson['content'];
        time = mapFromJson['time'];
        setTime(time);
        print('接下来是时间时间接下来是时间时间接下来是时间时间');
        print(prevTime);
        print(time);
        if(prevTime != time){
          await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
                  title: new Text('通知:$title'),
                  content: new Text(content),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: new Text('确定'),
                    ),
                  ],
                ));
        }
        
      } else if (mapFromJson['status'] == 20000) {
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("请求失败"),
          action: new SnackBarAction(
            label: "网络错误",
            onPressed: () {},
          ),
        ));
      }
    } on Error catch (e) {
      //Faliure();
    }
    return;
  }

  List<Widget> list = List();
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _controller.jumpToPage(index);
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('你按下了返回'),
            content: new Text('确定退出程序？'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('取消'),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: new Text('退出程序'),
              ),
            ],
          ),
        )) ??
        false;
  }

  final _widgetOptions = [
    MyGoalsAndPrinciplesPage(),
    DiscoverPage(),
    DocumentPage(),
  ];

  @override
  Widget build(BuildContext context) {
    GetNotificatinon();
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        //body: list[_currentIndex],
        body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _widgetOptions.elementAt(index);
          },
          itemCount: _widgetOptions.length,
          controller: _controller,
        ),
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
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
