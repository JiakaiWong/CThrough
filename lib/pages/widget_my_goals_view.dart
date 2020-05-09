import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget_edit_goal_utility.dart';

class MyGoalPage extends StatefulWidget {
  MyGoalPage({Key key}) : super(key: key);

  @override
  _MyGoalPageState createState() => _MyGoalPageState();
}

class _MyGoalPageState extends State<MyGoalPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Map<String, dynamic> mapFromJson;

  Future<bool> Failure() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('出错'),
            content: new Text('请稍后再试'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('Navigator'));
                },
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  //get uuid from local shared_preference
  Future<String> getUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var myuuid = prefs.getString('uuid');
    print(myuuid);
    return myuuid;
  }

  Future<int> GetMyGoalData() async {
    var myuuid = await getUuid();
    print('begin GetMyGoalData');
    Response response;
    try {
      var data = {'uuid': myuuid};
      response = await post(
        "http://47.107.117.59/fff/getTargets.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      listOfBareFiveStep.removeRange(0, listOfBareFiveStep.length);
      if (mapFromJson['status'] == 10000) {
        print('请求成功');
        print(mapFromJson);
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          print(mapFromJson['sum']);
          listOfBareFiveStep.add(BareFiveStep(
            uuid: 'new uuid',
          ));
        }
        print('第一遍覆盖结束');
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfBareFiveStep[i].uuid = mapFromJson['results'][i]['tuid'];
          listOfBareFiveStep[i].problems_identified =
              mapFromJson['results'][i]['problem'];
          listOfBareFiveStep[i].root_causes_identified =
              mapFromJson['results'][i]['reason'];
          listOfBareFiveStep[i].goal_setted = mapFromJson['results'][i]['goal'];
          listOfBareFiveStep[i].plan_designed =
              mapFromJson['results'][i]['plan'];
          listOfBareFiveStep[i].action_performed =
              mapFromJson['results'][i]['action'];
        }
        print('我的目标列表存储结束,长度为：');
        print(listOfBareFiveStep.length);
      } else if (mapFromJson['status'] == 20000) {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');

      Failure();
    }
    return listOfBareFiveStep.length;
  }

  Future DeleteGoal(String tuid) async {
    print('开始删除目标');
    Response response;
    try {
      var data = {'tuid': tuid};
      response = await post(
        "http://47.107.117.59/fff/deleteTarget.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      if (mapFromJson['status'] == 10000) {
        Navigator.popUntil(context, ModalRoute.withName('Navigator'));
        print('删除成功');
      } else if (mapFromJson['status'] == 20000) {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');
      Failure();
    }
  }

  Future DeleteGoalWithWarning(String tuid) async {
    print('开始有警告的删除目标');
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('确定要删除这个目标吗'),
            content: new Text(''),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  DeleteGoal(tuid);
                },
                child: new Text('确定'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('取消'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget futureWidget() {
    return new FutureBuilder(
        future: GetMyGoalData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('未请求');
            case ConnectionState.waiting:
              {
                return new Text('Awaiting result...');
              }
            default:
              if (snapshot.hasError) {
                print('snapshot.hasError');
                return new Text('Error: ${snapshot.error}');
              } else {
                print('开始build我的目标列表');
                return new Scaffold(
                  body: new ListView.builder(
                      itemCount: snapshot.data,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Dismissible(
                            key: Key('keyOfFiveStepCard$index'),
                            onDismissed: (direction) {
                              var _snackStr = '删除了一个目标';
                              if (direction == DismissDirection.endToStart) {
                                // 从右向左
                                _snackStr = '从右向左删除了目标';
                              } else if (direction ==
                                  DismissDirection.startToEnd) {
                                _snackStr = '从左向右删除了目标';
                              }
                              DeleteGoalWithWarning(
                                  listOfBareFiveStep[index].uuid);
                              // 展示 SnackBar
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(_snackStr),
                              ));
                              setState(() {});
                            },
                            background: Container(
                              color: Colors.red,
                              child: ListTile(
                                title: Text(
                                  '''
你快
删除我啊
                                    ''',
                                  textScaleFactor: 2.0,
                                ),
                                leading: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                trailing: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.blue,
                              child: ListTile(
                                title: Text(
                                  '''
        说实话我觉得你这个挫人要完成点目标还真不容易呢，要不你就把它放删除了好了。
''',
                                  textScaleFactor: 2.0,
                                ),
                                trailing: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: MyFiveStepCard(
                              uuid: listOfBareFiveStep[index].uuid,
                              goal_setted:
                                  listOfBareFiveStep[index].goal_setted,
                              problems_identified:
                                  listOfBareFiveStep[index].problems_identified,
                              root_causes_identified: listOfBareFiveStep[index]
                                  .root_causes_identified,
                              plan_designed:
                                  listOfBareFiveStep[index].plan_designed,
                              action_performed:
                                  listOfBareFiveStep[index].action_performed,
                            ),
                          ),
                        );
                      }),
                  floatingActionButton: FloatingActionButton.extended(
                      label: Text('新的目标'),
                      icon: Icon(Icons.add_circle_outline),
                      heroTag: 'addGoal',
                      onPressed: () {
                        Navigator.pushNamed(context, 'addTagPage');
                      }),
                );
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return futureWidget();
  }
}
