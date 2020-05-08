import 'package:date_matching/pages/page_discover_principle.dart';
import 'package:date_matching/pages/page_my_following.dart';
import 'package:flutter/material.dart';
import 'page_discover_goal.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text(' ');
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
              title: cusSearchBar,
              leading: Container(),
              actions: <Widget>[
                IconButton(
                  icon: cusIcon,
                  onPressed: () {
                    setState(() {
                      if (this.cusIcon.icon == Icons.search) {
                        this.cusIcon = Icon(Icons.cancel);
                        this.cusSearchBar = TextField(
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Item',
                          ),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        );
                      } else {
                        this.cusIcon = Icon(Icons.search);
                        this.cusSearchBar = Text(' ');
                      }
                    });
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
          ],
        ),
      ),
    );
  }
}
