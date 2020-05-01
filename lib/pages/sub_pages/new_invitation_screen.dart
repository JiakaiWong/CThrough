import 'package:flutter/material.dart';

class NewInvitationPage extends StatefulWidget {
  @override
  _NewInvitationPageState createState() => _NewInvitationPageState();
}

class _NewInvitationPageState extends State<NewInvitationPage> {
  List<bool> checkboxesForConsumptivePower = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布邀请'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.75,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: '地点',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                maxLength: 100,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: '时间',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
                maxLength: 100,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: '几句话介绍',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
                maxLength: 300,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Text('消费偏好'),
                          Expanded(
                              flex: 20,
                              child: SizedBox(
                                height: 30,
                              ))
                        ],
                      ),
                    ),
                    new Center(
                      child: new CheckboxListTile(
                          value: checkboxesForConsumptivePower[0],
                          title: new Text('穷游'),
                          controlAffinity: ListTileControlAffinity.platform,
                          onChanged: (bool) {
                            setState(() {
                              checkboxesForConsumptivePower[0] = bool;
                            });
                          }),
                    ),
                    new Center(
                      child: new CheckboxListTile(
                          activeColor: Colors.grey,
                          checkColor: Colors.grey,
                          value: checkboxesForConsumptivePower[1],
                          title: new Text('小额消费'),
                          controlAffinity: ListTileControlAffinity.platform,
                          onChanged: (bool) {
                            setState(() {
                              checkboxesForConsumptivePower[1] = bool;
                            });
                          }),
                    ),
                    new Center(
                      child: new CheckboxListTile(
                          activeColor: Colors.grey,
                          checkColor: Colors.grey,
                          value: checkboxesForConsumptivePower[2],
                          title: new Text('小资消费'),
                          controlAffinity: ListTileControlAffinity.platform,
                          onChanged: (bool) {
                            setState(() {
                              checkboxesForConsumptivePower[2] = bool;
                            });
                          }),
                    ),
                    new Center(
                      child: new CheckboxListTile(
                          activeColor: Colors.grey,
                          checkColor: Colors.grey,
                          value: checkboxesForConsumptivePower[3],
                          title: new Text('高端消费'),
                          controlAffinity: ListTileControlAffinity.platform,
                          onChanged: (bool) {
                            setState(() {
                              checkboxesForConsumptivePower[3] = bool;
                            });
                          }),
                    ),
                  ],
                ),
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
                      '发布邀请',
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
