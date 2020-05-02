import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  CreateAccountState createState() => CreateAccountState();
}

class CreateAccountState extends State<CreateAccount> {
  List<bool> checkboxesForConsumptivePower = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册账户'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              
              TextField(
                decoration: InputDecoration(
                    hintText: '邮箱',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                maxLength: 30,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: '验证码',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                      maxLength: 6,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: FlatButton(
                      onPressed: () {
                        //Navigator.pop(context);
                      },
                      child: Container(
                        //height: 30,
                        //width: 80,
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            '发送验证码',
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: '密码',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
                maxLength: 50,
              ),
              
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
