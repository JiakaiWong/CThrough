//查看某一个用户的内容

import 'dart:convert';
import 'package:date_matching/pages/widget_edit_goal_utility.dart';
import 'package:date_matching/pages/widget_persontile_utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

//用于异步读取本地json

// Future<String> _loadDocumentFile() async {
//   return await rootBundle.loadString('lib/assets/Document.json');
// }

// Future wait(int milliseconds) {
//   return new Future.delayed(Duration(milliseconds: milliseconds), () => {});
// }

// Future<PersonTileData> loadDocument() async {
//   await wait(1000);
//   String jsonString = await _loadDocumentFile();
//   final jsonResponse = json.decode(jsonString);
//   return new PersonTileData.fromJson(jsonResponse);
// }

//查看其他人
class OtherPeopleDocumentPage extends StatefulWidget {
  @override
  _OtherPeopleDocumentPageState createState() =>
      _OtherPeopleDocumentPageState();
}

class _OtherPeopleDocumentPageState extends State<OtherPeopleDocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('HisScaffold'),
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
      ),
      body: Padding(
        key: Key('OtherPeopleDocumentPage'),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          key: Key('OtherPeopleDocumentPage'),
          children: <Widget>[
            OtherPeoplePersonTile(),
            Expanded(child: SizedBox(child: HisGoalView())),
          ],
        ),
      ),
    );
  }
}

class HisGoalView extends StatefulWidget {
  HisGoalView({Key key}) : super(key: key);

  @override
  _HisGoalViewState createState() => _HisGoalViewState();
}

class _HisGoalViewState extends State<HisGoalView> {
  var othersUuid;

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

  //get uuid from local shared_preference
  Future<String> getHisUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentViewingPerson');
  }

  Future<int> GetOthersGoalData() async {
    othersUuid = await getHisUuid();
    print('开始获取对方的目标');
    Response response;
    try {
      var data = {'uuid': othersUuid};
      response = await post(
        "http://47.107.117.59/fff/getTargets.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      listOfHisBareFiveStep.removeRange(0, listOfHisBareFiveStep.length);
      if (mapFromJson['status'] == 10000) {
        print('请求成功');
        print(mapFromJson);
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          print(mapFromJson['sum']);
          listOfHisBareFiveStep.add(BareFiveStep(
            uuid: 'new uuid',
          ));
        }
        print('第一遍覆盖结束');
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfHisBareFiveStep[i].uuid = mapFromJson['results'][i]['tuid'];
          listOfHisBareFiveStep[i].problems_identified =
              mapFromJson['results'][i]['problem'];
          listOfHisBareFiveStep[i].root_causes_identified =
              mapFromJson['results'][i]['reason'];
          listOfHisBareFiveStep[i].goal_setted =
              mapFromJson['results'][i]['goal'];
          listOfHisBareFiveStep[i].plan_designed =
              mapFromJson['results'][i]['plan'];
          listOfHisBareFiveStep[i].action_performed =
              mapFromJson['results'][i]['action'];
        }
        print('对象的目标列表存储结束,长度为：');
        print(listOfHisBareFiveStep.length);
      } else if (mapFromJson['status'] == '20000') {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');

      Failure();
    }
    return listOfHisBareFiveStep.length;
  }

  Widget futureWidget() {
    Key('hisGoalFutureBuilder');

    return new FutureBuilder(
        key: Key('hisGoalFutureBuilder'),
        future: GetOthersGoalData(),
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
                print('开始build他的目标列表');
                return new ListView.builder(
                    key: Key('HisGoalView'),
                    itemCount: snapshot.data,
                    itemBuilder: (context, index) {
                      return Padding(
                        key: Key('hisGoalList$index'),
                        padding: const EdgeInsets.all(8.0),
                        child: DumbFiveStepCard(
                          key: Key('hisGoalList$index'),
                          uuid: listOfHisBareFiveStep[index].uuid,
                          goal_setted: listOfHisBareFiveStep[index].goal_setted,
                          problems_identified:
                              listOfHisBareFiveStep[index].problems_identified,
                          root_causes_identified: listOfHisBareFiveStep[index]
                              .root_causes_identified,
                          plan_designed:
                              listOfHisBareFiveStep[index].plan_designed,
                          action_performed:
                              listOfHisBareFiveStep[index].action_performed,
                        ),
                      );
                    });
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return futureWidget();
  }
}

//别人的个人信息标签
class OtherPeoplePersonTile extends StatefulWidget {
  @override
  _OtherPeopleTileState createState() => _OtherPeopleTileState();
}

class _OtherPeopleTileState extends State<OtherPeoplePersonTile> {
  var othersUuid;

  Widget futureWidget() {
    PersonTileData personTileData = PersonTileData(
      uuid: 'default',
      avatarId: 1,
      userName: '正在加载昵称',
      userIdentity: '正在加载身份',
      followed: 0,
    );

    Future<bool> Failure() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('无法获取个人信息'),
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

    //get uuid from local shared_preference
    Future<String> getHisUuid() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      personTileData.uuid = prefs.getString('currentViewingPerson');
      return personTileData.uuid;
    }

    Future<Null> GetPersonTileData() async {
      var othersUuid = await getHisUuid();
      Response response;
      try {
        var data = {'uuid': othersUuid};
        response = await post(
          "http://47.107.117.59/fff/getUserInfo.php",
          body: data,
        );
        Map<String, dynamic> mapFromJson =
            json.decode(response.body.toString());
        if (mapFromJson['status'] == 10000) {
          print('请求成功');
          personTileData.avatarId = mapFromJson['avartarId'];
          personTileData.followed = mapFromJson['followed'];
          personTileData.userIdentity = mapFromJson['identity'];
          personTileData.userName = mapFromJson['nick'];
          print(personTileData.avatarId);
          print(personTileData.userName);
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
      return;
    }

    return new FutureBuilder<PersonTileData>(
        future: GetPersonTileData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Press button to start');
            case ConnectionState.waiting:
              return new Text('Awaiting result...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else //若_calculation执行正常完成
                return Column(
                  children: <Widget>[
                    BigPersonalTile(
                      key: Key('HisPersonTileData${personTileData.uuid}'),
                      //在futur builder 中返回一个个人资料栏
                      userName: personTileData.userName,
                      userIdentity: personTileData.userIdentity,
                      followed: personTileData.followed,
                      avatarId: personTileData.avatarId,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                            color: Colors.grey,
                            onPressed: () {
                              FollowHim();
                            },
                            child: Text('关注')),
                        FlatButton(
                            color: Colors.grey,
                            onPressed: () {
                              UnFollowHim();
                            },
                            child: Text('取消关注')),
                      ],
                    )
                  ],
                );
          }
        });
  }

  var myUuid;
  //get uuid from local shared_preference
  Future<String> getUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //set uuid
    myUuid = prefs.getString('uuid');
    return myUuid;
  }

  //get uuid from local shared_preference
  Future<String> getHisUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentViewingPerson');
  }

  Future<bool> Failure() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('无法获取个人信息'),
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

  Future<bool> FollowSucceed() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('成功关注了Ta'),
            content: new Text('他的被关注数将在重新进入页面后更新'),
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

  Future<bool> UnFollowSucceed() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('成功取消关注了Ta'),
            content: new Text('他的被关注数将在重新进入页面后更新'),
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

  Future<Null> FollowHim() async {
    othersUuid = await getHisUuid();
    myUuid = await getUuid();
    Response response;
    try {
      var data = {'uuid': myUuid, 'touid': othersUuid};
      response = await post(
        "http://47.107.117.59/fff/follow.php",
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        FollowSucceed();
        print('请求成功');
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
    return;
  }

  Future<Null> UnFollowHim() async {
    othersUuid = await getHisUuid();
    myUuid = await getUuid();
    Response response;
    try {
      var data = {'uuid': myUuid, 'touid': othersUuid};
      response = await post(
        "http://47.107.117.59/fff/fuckfollow.php",
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        UnFollowSucceed();
        print('请求成功');
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
    return;
  }

  @override
  Widget build(BuildContext context) {
    return futureWidget();
  }
}
