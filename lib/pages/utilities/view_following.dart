import 'package:flutter/material.dart';
import 'avatar_and_nickname_tile.dart';

class ViewFollowingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
    title: Text('我的关注'),
    elevation: 0,
        ),
        body: AvatarAndPersonalMessageTileScrollView(),
        );
  }
}


