import 'dart:convert';

import 'widget_principle_card.dart';
import 'package:flutter/material.dart';
import 'widget_discovery_card.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> _loadPrincipleFile() async {
  return await rootBundle.loadString('lib/assets/Goals.json');
}

Future wait(int milliseconds) {
  return new Future.delayed(Duration(milliseconds: milliseconds), () => {});
}

Future<BarePrinciple> loadPrinciple() async {
  await wait(500);
  String jsonString = await _loadPrincipleFile();
  final jsonResponse = json.decode(jsonString);
  return new BarePrinciple.fromJson(jsonResponse);
}

class DiscoverRecommended extends StatefulWidget {
  @override
  _DiscoverRecommendedState createState() => _DiscoverRecommendedState();
}

class _DiscoverRecommendedState extends State<DiscoverRecommended> {
  Widget futureWidget() {
    return new FutureBuilder<BarePrinciple>(
        future: loadPrinciple(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: ListView(
                children: <Widget>[
                  PrincipleCard(
                      principleText: snapshot.data.principleText,
                      principleDescription: snapshot.data.principleDescription),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return new Text("${snapshot.hasError}");
          }
          return Center(child: new CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return futureWidget();
  }
}
