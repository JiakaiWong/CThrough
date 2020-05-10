import 'dart:convert';

import 'package:date_matching/pages/widget_edit_goal_utility.dart';
import 'package:date_matching/pages/widget_persontile_utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DiscoverBaoyan extends StatefulWidget {
  DiscoverBaoyan({Key key}) : super(key: key);

  @override
  _DiscoverBaoyanState createState() => _DiscoverBaoyanState();
}

class _DiscoverBaoyanState extends State<DiscoverBaoyan>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Map<String, dynamic> mapFromJson;
  List listOfSearchedTuid = List<String>();
  List listOfSearchedPersonTileData = List<PersonTileData>();
  List listOfSearchedBareFiveStep = List<OthersBareFiveStep>();
  int sum = 50;

//获得tuid
  Future<int> GerSearchedGoals() async {
    print('begin GerSearchedGoals');
    Response response;
    try {
      var data = {'tag': '保研'};
      response = await post(
        "http://47.107.117.59/fff/getTTag.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      listOfSearchedTuid.removeRange(0, listOfSearchedTuid.length);
      listOfSearchedPersonTileData.removeRange(
          0, listOfSearchedPersonTileData.length);
      if (mapFromJson['status'] == 10000) {
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfSearchedTuid.add('');
        }
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfSearchedTuid[i] = mapFromJson['results'][i]['tuid'];
        }
      } else if (mapFromJson['status'] == 20000) {
        print('失败码');
      }
    } on Error catch (e) {
      print(e);
      print('出错');
    }
    print('GerSearchedGoals finished,with length${listOfSearchedTuid.length}');
    return listOfSearchedTuid.length;
  }

//获得一个data
  Future<Null> GetBareFiveStepData(int currentTuid) async {
    var tuid = listOfSearchedTuid[currentTuid];
    Response response;
    try {
      var data = {'tuid': tuid};
      response = await post(
        "http://47.107.117.59/fff/getFuckTarget.php",
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        listOfSearchedBareFiveStep[currentTuid].uuid = mapFromJson['uuid'];
        listOfSearchedBareFiveStep[currentTuid].goal_setted =
            mapFromJson['goal'];
        listOfSearchedBareFiveStep[currentTuid].problems_identified =
            mapFromJson['problem'];
        listOfSearchedBareFiveStep[currentTuid].root_causes_identified =
            mapFromJson['reason'];
        listOfSearchedBareFiveStep[currentTuid].plan_designed =
            mapFromJson['plan'];
        listOfSearchedBareFiveStep[currentTuid].action_performed =
            mapFromJson['action'];
        listOfSearchedPersonTileData[currentTuid].uuid = mapFromJson['uuid'];
      } else if (mapFromJson['status'] == 20000) {
        print('GetBareFiveStepData 请求失败');
      }
    } on Error catch (e) {
      print(e);
    }
  }

  //用for循环轮一遍listOfSearchedTuid
  Future<bool> GetFullBareFiveStepData(int length) async {
    for (int i = 0; i < length; i++) {
      listOfSearchedBareFiveStep.add(OthersBareFiveStep(
        goal_setted: '默认目标',
        problems_identified: ' ',
        root_causes_identified: ' ',
        plan_designed: ' ',
        action_performed: ' ',
      ));
      listOfSearchedPersonTileData.add(PersonTileData(
        uuid: 'default uuid',
      ));
    }
    for (int i = 0; i < length; i++) {
      GetBareFiveStepData(i).then((Response) {
        GetPersonTileData(i);
      });
    }
    return true;
  }

  Future<Null> GetPersonTileData(int currentIndex) async {
    print('beginGetPersonTileData');

    Response response;
    try {
      var data = {'uuid': listOfSearchedPersonTileData[currentIndex].uuid};
      response = await post(
        "http://47.107.117.59/fff/getUserInfo.php",
        body: data,
      );
      print(data);
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        listOfSearchedPersonTileData[currentIndex].avatarId =
            mapFromJson['avartarId'];
        print(
            'listOfSearchedPersonTileData[currentIndex].avatarId:${listOfSearchedPersonTileData[currentIndex].avatarId}');
        listOfSearchedPersonTileData[currentIndex].followed =
            mapFromJson['followed'];
        listOfSearchedPersonTileData[currentIndex].userIdentity =
            mapFromJson['identity'];
        listOfSearchedPersonTileData[currentIndex].userName =
            mapFromJson['nick'];
        print('个人信息赋值结束');
      } else if (mapFromJson['status'] == 20000) {
        print('GetPersonTileData' + '请求失败');
      }
    } on Error catch (e) {
      print(e);
    }
  }

  Future runMultipleFutures(int i) async {
    var futures = List<Future>();
    futures.add(GetFullBareFiveStepData(i));
    await Future.wait(futures);
    futures.add(Future.delayed(const Duration(milliseconds: 1000), () {
      futures.add(GetPersonTileData(i));
    }));
    await Future.wait(futures);
  }

  Widget futureWidget() {
    return new FutureBuilder(
        future: GerSearchedGoals(), //第一层：得到了一个tuid数组，保存在listOfSearchedTuid
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
                print('GerSearchedGoals.hasError');
                return new Text('Error: ${snapshot.error}');
              } else {
                return new FutureBuilder(
                    future:
                        runMultipleFutures(snapshot.data), //这里开始用目标的信息获取人的信息
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
                            print('GetFullBareFiveStepData.hasError');
                            return new Text('Error: ${snapshot.error}');
                          } else {
                            return new Scaffold(
                                body: new ListView.builder(
                                    itemCount: listOfSearchedTuid.length,
                                    itemBuilder: (context, index) {
                                      return new Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TheirPersonTileWithGoal(
                                          key: Key(
                                              'SearchedPersonTileWith$index'),
                                          uuid: listOfSearchedPersonTileData[
                                                  index]
                                              .uuid,
                                          userIdentity:
                                              listOfSearchedPersonTileData[
                                                      index]
                                                  .userIdentity,
                                          userName:
                                              listOfSearchedPersonTileData[
                                                      index]
                                                  .userName,
                                          avatarId:
                                              listOfSearchedPersonTileData[
                                                      index]
                                                  .avatarId,
                                          followed:
                                              listOfSearchedPersonTileData[
                                                      index]
                                                  .followed,
                                          goal_setted:
                                              listOfSearchedBareFiveStep[index]
                                                  .goal_setted,
                                          problems_identified:
                                              listOfSearchedBareFiveStep[index]
                                                  .problems_identified,
                                          root_causes_identified:
                                              listOfSearchedBareFiveStep[index]
                                                  .root_causes_identified,
                                          plan_designed:
                                              listOfSearchedBareFiveStep[index]
                                                  .plan_designed,
                                          action_performed:
                                              listOfSearchedBareFiveStep[index]
                                                  .action_performed,
                                        ),
                                      );
                                    }));
                          }
                      }
                    });
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return futureWidget();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: ListView(
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: TheirPersonTileWithGoal(
  //             uuid: '7ab23f50-8e19-11ea-f37d-13590433e3bd',
  //             userIdentity: 'ETH',
  //             userName: '17届scut-CS-BS,class2020 UM-wisconsin',
  //             avatarId: 1,
  //             followed: 232,
  //             goal_setted: '去ZhengDong Su实验室',
  //             problems_identified: '需要年级排名top5%～top15%，TOFEL105，GRE score，实验室科研项目，有paper最好，实习经历、cs相关的比赛',
  //             root_causes_identified: '身边人似乎都没什么干劲，我老师觉得没有压力、造成各种效率下降',
  //             plan_designed: '在facebook结交了很多志同道合的朋友',
  //             action_performed:
  //                 '用5%的成绩排名和3篇论文成功获得ETHoffer',
  //           ),
  //         ),
  //       ],
  //     ),
  //   ));
  // }
}
