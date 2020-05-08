import 'dart:convert';
import 'package:date_matching/pages/widget_persontile_utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoverMyFollowing extends StatefulWidget {
  DiscoverMyFollowing({Key key}) : super(key: key);

  @override
  _DiscoverMyFollowingState createState() => _DiscoverMyFollowingState();
}

class _DiscoverMyFollowingState extends State<DiscoverMyFollowing>
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

  //get puid from local shared_preference
  Future<String> getUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var myuuid = prefs.getString('uuid');
    return myuuid;
  }

  Future<int> GetMyFollowingUuid() async {
    print('begin GetMyFollowingUuid');
    var myuuid = await getUuid();

    Response response;
    try {
      var data = {'num': '$sum', 'uuid': myuuid};
      response = await post(
        "http://47.107.117.59/fff/recommendUsers.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      listOfMyFollowingUuid.removeRange(0, listOfMyFollowingUuid.length);
      if (mapFromJson['status'] == 10000) {
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfMyFollowingUuid.add('default uuid');
        }
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfMyFollowingUuid[i] = mapFromJson['results'][i]['uuid'];
        }
        print('关注的人的uuid列表存储结束,长度为：');
        print(listOfMyFollowingUuid.length);
      } else if (mapFromJson['status'] == 20000) {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');
      Failure();
    }
    return listOfMyFollowingUuid.length;
  }

  Future<PersonTileData> GetPersonTileData(int currentPerson) async {
    PersonTileData personTileData = PersonTileData(
      uuid: listOfMyFollowingUuid[currentPerson],
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
        future: GetMyFollowingUuid(),
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
                  key: Key('myFollowingPeople'),
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
                                      child: TheirPersonTile(
                                        key: Key('TheirPersonTileList$index'),
                                        uuid: snapshot.data.uuid,
                                        userIdentity:
                                            snapshot.data.userIdentity,
                                        userName: snapshot.data.userName,
                                        avatarId: snapshot.data.avatarId,
                                        followed: snapshot.data.followed,
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
