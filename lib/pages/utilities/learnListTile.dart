import 'package:flutter/material.dart';
class LearnCheckBox extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _LearnCheckBox();
  }
}
class _LearnCheckBox extends State<LearnCheckBox>{
  bool isCheck=false;
  List<bool> isChecks=[false,false];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Center(
            child: new Checkbox(
              value: isCheck,
              activeColor: Colors.red,
              onChanged: (bool){
                setState(() {
                  isCheck=bool;
                });
              },
            ),
          ),
          new Center(
            child: new CheckboxListTile(
                value: isCheck,
                title: new Text('张晓'),
                controlAffinity: ListTileControlAffinity.platform,//控制亲和度  leading按钮显示在文字前面  trailing按钮显示在文字的后面   platform显示样式根据手机当前平台默认显示
                onChanged: (bool){
                  setState(() {
                    isCheck=bool;
                  });
                }),
          ),
          new Center(
            child: new CheckboxListTile(
                value: isCheck,
                title: new Text('张晓'),
                controlAffinity: ListTileControlAffinity.platform,
                onChanged: (bool){
                  setState(() {
                    isCheck=bool;
                  });
                }),
          ),
          new Center(
            child: new CheckboxListTile(
                value: isCheck,
                title: new Text('张晓'),
                controlAffinity: ListTileControlAffinity.platform,
                onChanged: (bool){
                  setState(() {
                    isCheck=bool;
                  });
                }),
          ),
          new Center(
            child: new CheckboxListTile(
                value: isCheck,
                title: new Text('张晓'),
                controlAffinity: ListTileControlAffinity.platform,
                onChanged: (bool){
                  setState(() {
                    isCheck=bool;
                  });
                }),
          ),
          new Center(
            child: new CheckboxListTile(
                value: isCheck,
                title: new Text('张晓'),
                controlAffinity: ListTileControlAffinity.platform,
                onChanged: (bool){
                  setState(() {
                    isCheck=bool;
                  });
                }),
          ),
          new Center(
            child: new CheckboxListTile(
                value: isChecks[0],
                title: new Text('张晓'),
                controlAffinity: ListTileControlAffinity.platform,
                onChanged: (bool){
                  setState(() {
                    isChecks[0]=bool;
                  });
                }),
          ),
          new Center(
            child: new CheckboxListTile(
                value: isChecks[1],
                title: new Text('张晓'),
                controlAffinity: ListTileControlAffinity.platform,
                onChanged: (bool){
                  setState(() {
                    isChecks[1]=bool;
                  });
                }),
          ),
          Card(child: ListTile(title: Text(''))),
          Card(
            child: ListTile(
              title: Text(''),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(''),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(''),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(''),
              dense: true,
            ),
          ),
          Card(
            child: ListTile(
              title: Text(''),
              subtitle: Text(''),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(''),
              subtitle:
                  Text(''),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
            ),
          ),
          
        ],
      )
    );
  }
}