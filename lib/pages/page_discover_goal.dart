import 'dart:convert';
import 'package:date_matching/pages/widget_persontile_utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget_edit_goal_utility.dart';
import 'package:date_matching/pages/widget_persontile_utility.dart';

class DiscoverNewGoalsWithPersonInfo extends StatefulWidget {
  DiscoverNewGoalsWithPersonInfo({Key key}) : super(key: key);

  @override
  _DiscoverNewGoalsWithPersonInfoState createState() =>
      _DiscoverNewGoalsWithPersonInfoState();
}

class _DiscoverNewGoalsWithPersonInfoState
    extends State<DiscoverNewGoalsWithPersonInfo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int sum = 50;
  Map<String, dynamic> mapFromJson;

  Future<bool> Failure() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('出错'),
            content: new Text('请稍后再试'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<int> GetRecommendedGoals() async {
    print('begin GetRecommendedGoals');
    Response response;
    try {
      var data = {'num': '$sum'};
      response = await post(
        "http://47.107.117.59/fff/recommendTargets.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      listOfOthersBareFiveStep.removeRange(0, listOfOthersBareFiveStep.length);

      if (mapFromJson['status'] == 10000) {
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfOthersBareFiveStep.add(OthersBareFiveStep(
            goal_setted: '默认目标',
            problems_identified: ' ',
            root_causes_identified: ' ',
            plan_designed: ' ',
            action_performed: ' ',
          ));
        }
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfOthersBareFiveStep[i].uuid = mapFromJson['results'][i]['uuid'];
          listOfOthersBareFiveStep[i].problems_identified =
              mapFromJson['results'][i]['problem'];
          listOfOthersBareFiveStep[i].root_causes_identified =
              mapFromJson['results'][i]['reason'];
          listOfOthersBareFiveStep[i].goal_setted =
              mapFromJson['results'][i]['goal'];
          listOfOthersBareFiveStep[i].plan_designed =
              mapFromJson['results'][i]['plan'];
          listOfOthersBareFiveStep[i].action_performed =
              mapFromJson['results'][i]['action'];
        }
        print('别人的目标列表存储结束,长度为：');
        print(listOfOthersBareFiveStep.length);
      } else if (mapFromJson['status'] == 20000) {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');

      Failure();
    }
    return listOfOthersBareFiveStep.length;
  }

  Future<PersonTileData> GetPersonTileData(int currentPerson) async {
    PersonTileData personTileData = PersonTileData(
      uuid: listOfOthersBareFiveStep[currentPerson].uuid,
      avatarId: 0,
      userName: '加载失败',
      userIdentity: '',
      followed: 0,
    );
    Response response;
    try {
      var data = {'uuid': personTileData.uuid};
      response = await post(
        "http://47.107.117.59/fff/getUserInfo.php",
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        print('请求成功');
        personTileData.avatarId = mapFromJson['avartarId'];
        personTileData.followed = mapFromJson['followed'];
        personTileData.userIdentity = mapFromJson['identity'];
        personTileData.userName = mapFromJson['nick'];
      } else if (mapFromJson['status'] == 20000) {
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("请求失败"),
          action: new SnackBarAction(
            label: "OK",
            onPressed: () {},
          ),
        ));
      }
    } on Error catch (e) {
      print(e);
      Failure();
    }
    return personTileData;
  }

  Widget futureWidget() {
    return new FutureBuilder(
        future: GetRecommendedGoals(),
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
                return new Scaffold(
                  key: Key('recommendedGoalsWithPersonInfo'),
                  body: new ListView.builder(
                      itemCount: snapshot.data,
                      itemBuilder: (context, index) {
                        return new FutureBuilder(
                            future: GetPersonTileData(index),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
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
                                    return new Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TheirPersonTileWithGoal(
                                        key: Key(
                                            'TheirPersonTileWithGoal$index'),
                                        uuid: snapshot.data.uuid,
                                        userIdentity:
                                            snapshot.data.userIdentity,
                                        userName: snapshot.data.userName,
                                        avatarId: snapshot.data.avatarId,
                                        followed: snapshot.data.followed,
                                        goal_setted:
                                            listOfOthersBareFiveStep[index]
                                                .goal_setted,
                                        problems_identified:
                                            listOfOthersBareFiveStep[index]
                                                .problems_identified,
                                        root_causes_identified:
                                            listOfOthersBareFiveStep[index]
                                                .root_causes_identified,
                                        plan_designed:
                                            listOfOthersBareFiveStep[index]
                                                .plan_designed,
                                        action_performed:
                                            listOfOthersBareFiveStep[index]
                                                .action_performed,
                                      ),
                                    );
                                  }
                              }
                            });
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

class DiscoverNewGoals extends StatefulWidget {
  DiscoverNewGoals({Key key}) : super(key: key);

  @override
  _DiscoverMewGoalsState createState() => _DiscoverMewGoalsState();
}

class _DiscoverMewGoalsState extends State<DiscoverNewGoals>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int sum = 50;
  Map<String, dynamic> mapFromJson;

  Future<bool> Failure() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('出错'),
            content: new Text('请稍后再试'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<int> GetRecommendedGoals() async {
    print('begin GetRecommendedGoals');
    Response response;
    try {
      var data = {'num': '$sum'};
      response = await post(
        "http://47.107.117.59/fff/recommendTargets.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      listOfOthersBareFiveStep.removeRange(0, listOfOthersBareFiveStep.length);

      if (mapFromJson['status'] == 10000) {
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfOthersBareFiveStep.add(OthersBareFiveStep(
            goal_setted: '默认目标',
            problems_identified: ' ',
            root_causes_identified: ' ',
            plan_designed: ' ',
            action_performed: ' ',
          ));
        }
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfOthersBareFiveStep[i].uuid = mapFromJson['results'][i]['uuid'];
          listOfOthersBareFiveStep[i].problems_identified =
              mapFromJson['results'][i]['problem'];
          listOfOthersBareFiveStep[i].root_causes_identified =
              mapFromJson['results'][i]['reason'];
          listOfOthersBareFiveStep[i].goal_setted =
              mapFromJson['results'][i]['goal'];
          listOfOthersBareFiveStep[i].plan_designed =
              mapFromJson['results'][i]['plan'];
          listOfOthersBareFiveStep[i].action_performed =
              mapFromJson['results'][i]['action'];
        }
        print('别人的目标列表存储结束,长度为：');
        print(listOfOthersBareFiveStep.length);
      } else if (mapFromJson['status'] == 20000) {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');

      Failure();
    }
    return listOfOthersBareFiveStep.length;
  }

  Widget futureWidget() {
    return new FutureBuilder(
        future: GetRecommendedGoals(),
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
                return new Scaffold(
                  key: Key('recommendedGoals'),
                  body: new ListView.builder(
                      itemCount: snapshot.data,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TheirFiveStepCard(
                            key: Key('OthersRecentGoalList$index'),
                            uuid: listOfOthersBareFiveStep[index].uuid,
                            goal_setted:
                                listOfOthersBareFiveStep[index].goal_setted,
                            problems_identified: listOfOthersBareFiveStep[index]
                                .problems_identified,
                            root_causes_identified:
                                listOfOthersBareFiveStep[index]
                                    .root_causes_identified,
                            plan_designed:
                                listOfOthersBareFiveStep[index].plan_designed,
                            action_performed: listOfOthersBareFiveStep[index]
                                .action_performed,
                          ),
                        );
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
