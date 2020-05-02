import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    var _duration = new Duration(seconds: 3);

    if (firstTime != null && !firstTime) {// Not first time
      return new Timer(_duration, navigationPageHome);
    } else {// First time
      prefs.setBool('first_time', false);
      return new Timer(_duration, navigationPageWel);
    }
  }
  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed('Navigator');
  }

  void navigationPageWel() {

    Navigator.of(context).pushReplacementNamed('WelcomePage2');
  }


  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(children: <Widget>[
        
          Expanded(
          flex: 3,
          child: Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('lib/assets/background2.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: Center(
                    child:Container(
                  width: MediaQuery.of(context).size.width *3/4,
                  child: Text(
                    '''
    希望大家和我一样，把自己的失败经验，失败的人生，一字一句，仔仔细细的总结起来，和盘托出，毫无保留的，实名制的告诉全世界，告诉世界上的每一个人。           
                ————曾博''',
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                    textScaleFactor: 1.6,
                  ),
                ),
                  )
                  ),
                  Expanded(
                  flex: 3,
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios), 
                      iconSize: 50,
                      color: Colors.black,
                      onPressed:(){ Navigator.pushReplacementNamed(context, 'WelcomePage2');}
                      )
                  )
                  ),

              ]
            )
          ),
          ),
        
      ],),
    );
  }
}
