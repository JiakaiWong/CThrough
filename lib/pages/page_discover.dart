import 'dart:convert';

import 'package:date_matching/pages/page_discover_KAOYAN.dart';
import 'package:date_matching/pages/page_discover_masterdegree.dart';
import 'package:date_matching/pages/page_discover_principle.dart';
import 'package:date_matching/pages/page_my_following.dart';
import 'package:date_matching/pages/widget_edit_goal_utility.dart';
import 'package:date_matching/pages/widget_persontile_utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'page_discover_goal.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  //Widget cusSearchBar = Text(' ');
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
              // title: cusSearchBar,
              leading: Container(),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: searchBarDelegate());
                    // setState(() {
                    //   if (this.cusIcon.icon == Icons.search) {
                    //     this.cusIcon = Icon(Icons.cancel);
                    //     this.cusSearchBar = TextField(
                    //       textInputAction: TextInputAction.go,
                    //       decoration: InputDecoration(
                    //         border: InputBorder.none,
                    //         hintText: '搜索功能还未完成',
                    //       ),
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //       ),
                    //     );
                    //   } else {
                    //     this.cusIcon = Icon(Icons.search);
                    //     this.cusSearchBar = Text(' ');
                    //   }
                    // });
                  },
                )
              ],
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "别人的目标",
                  ),
                  Tab(
                    text: "别人的原则",
                  ),
                  Tab(
                    text: "关注的人",
                  ),
                  Tab(
                    text: '留学申请',
                  ),
                  Tab(
                    text: '保研专区',
                  ),
                ],
                indicatorColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
              )),
        ),
        body: TabBarView(
          children: <Widget>[
            DiscoverNewGoalsWithPersonInfo(),
            DiscoverPrinciplesWithPersonInfo(),
            DiscoverMyFollowing(),
            FakeDiscoverGoal(),
            FakeDiscoverKaoYan(),
          ],
        ),
      ),
    );
  }
}

class searchBarDelegate extends SearchDelegate<String> {
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
      var data = {'tag': query};
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
                    future: GetFullBareFiveStepData(
                        snapshot.data), //这里开始用目标的信息获取人的信息
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
                                      return new FutureBuilder(
                                          future: GetPersonTileData(index),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                                return new Text('未请求');
                                              case ConnectionState.waiting:
                                                {
                                                  return new Text(
                                                      'Awaiting result...');
                                                }
                                              case ConnectionState.active:
                                                {
                                                  return new Text(
                                                      'Awaiting result...');
                                                }
                                                
                                              default:
                                                if (snapshot.hasError) {
                                                  print('snapshot.hasError');
                                                  return new Text(
                                                      'Error: ${snapshot.error}');
                                                } else {
                                                  print('开始build卡片');
                                                  return new Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        TheirPersonTileWithGoal(
                                                      key: Key(
                                                          'SearchedPersonTileWith$index'),
                                                      uuid:
                                                          listOfSearchedPersonTileData[
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
                                                          listOfSearchedBareFiveStep[
                                                                  index]
                                                              .goal_setted,
                                                      problems_identified:
                                                          listOfSearchedBareFiveStep[
                                                                  index]
                                                              .problems_identified,
                                                      root_causes_identified:
                                                          listOfSearchedBareFiveStep[
                                                                  index]
                                                              .root_causes_identified,
                                                      plan_designed:
                                                          listOfSearchedBareFiveStep[
                                                                  index]
                                                              .plan_designed,
                                                      action_performed:
                                                          listOfSearchedBareFiveStep[
                                                                  index]
                                                              .action_performed,
                                                    ),
                                                  );
                                                }
                                            }
                                          });
                                    }));
                          }
                      }
                    });
              }
          }
        });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return futureWidget();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('dsadsa');
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context);
  }
}
