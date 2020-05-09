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
    String uuid = prefs.getString('uuid');
    print('uuid:');
    print(uuid);

    var _someDuration = new Duration(seconds: 2);
    var _zeroDuration = new Duration(seconds: 1);

    if (uuid != null) {
//已经登陆了
      return new Timer(_zeroDuration, navigationPageHome);
    } else {
      // First time
      prefs.setBool('first_time', false);
      return new Timer(_someDuration, navigationPageWel);
    }
  }

  void navigationPageWel() {
    Navigator.of(context).pushReplacementNamed('LogIn');
  }

  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed('Navigator');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, 'LogIn');
      },
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(flex: 2, child: Container()),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        child: Center(
                          child: Image(image: AssetImage('assets/Icon.jpg')),
                        ),
                      ),
                      Center(
                        child: Text(
                          'CThrough',
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              fontSize: 30.0,
                              //fontFamily: 'Cinzel',
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'evolotion ',
                                style: TextStyle(
                                    height: 1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                    color: Theme.of(context).iconTheme.color),
                              ),
                              TextSpan(
                                text: ' incited',
                                style: TextStyle(
                                    height: 1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    color: Theme.of(context).iconTheme.color),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(flex: 1, child: Container()),
              Center(
                child: Text(
                  'click to continue',
                  textScaleFactor: 1.4,
                  style:
                      TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ]),
      ),
    );
  }
}
