import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget_edit_principle_utility.dart';

class DiscoverPrinciples extends StatefulWidget {
  DiscoverPrinciples({Key key}) : super(key: key);

  @override
  _DiscoverPrinciplesState createState() => _DiscoverPrinciplesState();
}

class _DiscoverPrinciplesState extends State<DiscoverPrinciples>
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

  Future<int> GetRecommendedPrinciples() async {
    print('begin GetRecommendedPrinciples');
    Response response;
    try {
      var data = {'num': '$sum'};
      response = await post(
        "http://47.107.117.59/fff/recommendPrinciples.php",
        body: data,
      );
      var mapFromJson = json.decode(response.body);
      listOfOthersBarePrinciple.removeRange(
          0, listOfOthersBarePrinciple.length);

      if (mapFromJson['status'] == 10000) {
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfOthersBarePrinciple.add(OthersBarePrinciple(
            uuid: 'default uuid',
            principleText: ' ',
            principleDescription: ' ',
          ));
        }
        for (int i = 0; i < (mapFromJson['sum'] as int); i++) {
          listOfOthersBarePrinciple[i].uuid = mapFromJson['results'][i]['uuid'];
          listOfOthersBarePrinciple[i].principleText =
              mapFromJson['results'][i]['title'];
          listOfOthersBarePrinciple[i].principleDescription =
              mapFromJson['results'][i]['description'];
        }
        print('别人的原则列表存储结束,长度为：');
        print(listOfOthersBarePrinciple.length);
      } else if (mapFromJson['status'] == 20000) {
        print('失败码');
        Failure();
      }
    } on Error catch (e) {
      print(e);
      print('出错');

      Failure();
    }
    return listOfOthersBarePrinciple.length;
  }

  Widget futureWidget() {
    return new FutureBuilder(
        future: GetRecommendedPrinciples(),
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
                  key: Key('recommendedPrinciples'),
                  body: new ListView.builder(
                      itemCount: snapshot.data,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TheirPrincipleCard(
                            key: Key('OthersRecentGoalList$index'),
                            uuid: listOfOthersBarePrinciple[index].uuid,
                            principleDescription:
                                listOfOthersBarePrinciple[index]
                                    .principleDescription,
                            principleText:
                                listOfOthersBarePrinciple[index].principleText,
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
