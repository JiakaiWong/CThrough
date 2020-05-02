import 'package:flutter/material.dart';
import 'sub_pages/widget_my_goals_view.dart';
import 'sub_pages/widget_principle_card.dart';

class MyGoalsAndPrinciplesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: AppBar(
              bottom: TabBar(tabs: [
                Tab(
                  text: "我的目标",
                ),
                Tab(
                  text: "我的原则",
                ),
              ]),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              DemoPrincipleCardScrollView(),
              PrincipleCardScrollView(),
            ],
          )),
    );
  }
}
