import 'package:date_matching/pages/sub_pages/page_discover_following.dart';

import 'widget_principle_card.dart';
import 'package:flutter/material.dart';
import 'widget_discovery_card.dart';
import 'page_discover_nearby.dart';
import 'page_discover_recommend.dart';
import 'page_discover_search.dart';

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
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            title: cusSearchBar,
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
            bottom: TabBar(tabs: [
              Tab(
                text: "推荐的原则",
              ),
              Tab(
                text: "推荐的经历",
              ),
              Tab(
                text: "关注的人的原则",
              ),
              Tab(
                text: "关注的人的经历",
              ),

              // Tab(
              //   text: '搜索',
              // ),
            ]),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DiscoverRecommended(),
            DiscoverFollowing(),
            DiscoverNearby(),
            DiscoverNearby(),
          ],
        ),
      ),
    );
  }
}
