import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitPageTwo extends StatefulWidget {
  @override
  _InitPageTwoState createState() => _InitPageTwoState();
}

class _InitPageTwoState extends State<InitPageTwo> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    var _duration = new Duration(seconds: 15);

    if (firstTime != null && !firstTime) {
      // Not first time
      return new Timer(_duration, navigationPageHome);
    } else {
      // First time
      prefs.setBool('first_time', false);
      return new Timer(_duration, navigationPageWel);
    }
  }

  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed('LogIn');
  }

  void navigationPageWel() {
    Navigator.of(context).pushReplacementNamed('WelcomePage');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
                decoration: new BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  // image: DecorationImage(
                  //   image: new AssetImage('lib/assets/background2.jpg'),
                  //   fit: BoxFit.fill,
                  // ),
                ),
                child: Column(children: <Widget>[
                  Expanded(flex: 3,child: SizedBox()),
                  Expanded(
                      flex: 9,
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 3 / 4,
                          child: Text(
                            '''
        人与人的交往多半肤浅，或只有在较为肤浅的层面上，交往才是容易的，一旦走进深处，人与人就是相互的迷宫。   这是史铁生的名言，如今的互联网已经发展到后下沉阶段，其去中心化和互联网内容管制的结局是社群互联网价值贡献的降低以及社交媒体对个人成长促进作用的遗失，在Cthrough,我们赋予用户反思自己头脑深处迷宫的契机，并使广泛观察对比别人的迷宫成为可能，我们促使用户成为尼采所构思的Übermensch。这，便是Cthrough,一款移动端个人决策辅助系统的存在价值.
                ''',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            textScaleFactor: 1.6,
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Center(
                          child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              iconSize: 50,
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, 'LogIn');
                              }))),
                ])),
          ),
        ],
      ),
    );
  }
}
