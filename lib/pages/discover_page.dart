import 'package:flutter/material.dart';
import 'utilities/avatar_and_nickname_tile.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Discover'),
        //   elevation: 0,
        // ),
        body: AvatarAndPersonalMessageTileScrollView(),
        ),
    );
  }
}


