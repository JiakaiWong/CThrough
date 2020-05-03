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
      
      body: Column(children: <Widget>[
        
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
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: Center(
                    child:Container(
                  width: MediaQuery.of(context).size.width *3/4,
                  child: Text(
                    '''
    陌生人结识的障碍在于有太多不合，我们试图通过扣问心门的的追问让用户将心底的想法以及人生的行程暴露出来，提高陌生人社交的效率''',
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
                      onPressed:(){ Navigator.pushReplacementNamed(context, 'LogIn');}
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
