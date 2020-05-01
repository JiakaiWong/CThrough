// import 'dart:html';

import 'package:flutter/material.dart';

class _AvatarAndNickName extends StatelessWidget {
  _AvatarAndNickName({
    Key key,
    this.thumbnail, //图片

    this.nick_name,
    this.personal_message,
    this.liked,
    this.followed,
  }) : super(key: key); //constructor?
  final Widget thumbnail;
  final String nick_name;
  final String personal_message;
  final int liked;
  final int followed;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Align(
            child: AspectRatio(
              aspectRatio: 1,
              child: thumbnail,
            ),
          ),
        ),
        Expanded(flex: 1, child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$nick_name',
              textScaleFactor: 0.9,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '$personal_message',
                    textScaleFactor: 1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                
              ],
            ),
          ],
        ),),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
          ),
        ),
      ],
    );
    
  }
}

class AvatarAndPersonalMessageCard extends StatelessWidget {
  AvatarAndPersonalMessageCard({
    Key key,
    this.thumbnail, //图片
    this.nick_name,
    this.personal_message,
    this.liked,
    this.followed,
  }) : super(key: key);
  final Widget thumbnail;
  final String nick_name;
  final String personal_message;
  final int liked;
  final int followed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        child: new InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'PrincipleView');
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: _AvatarAndNickName(
                          thumbnail: thumbnail,
                          nick_name: nick_name,
                          personal_message: personal_message,
                          liked: liked,
                          followed: followed,
                        )),
                    Expanded(flex: 10, child: SizedBox())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AvatarAndPersonalMessageTileScrollView extends StatelessWidget {
  AvatarAndPersonalMessageTileScrollView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        AvatarAndPersonalMessageCard(
          thumbnail: Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('lib/assets/figure1.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          nick_name: '北大教授王铁崖',
          personal_message: '就要豪迈',
          liked: 100,
          followed: 30,
        ),
      ],
    );
  }
}
