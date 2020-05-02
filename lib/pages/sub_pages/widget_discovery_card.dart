// import 'dart:html';

import 'package:flutter/material.dart';
import 'widget_principle_card.dart';

//头像昵称签名和喜欢关注的一小条信息
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
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
              child: Align(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: thumbnail,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
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
                Text(
                  '$personal_message',
                  textScaleFactor: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '被喜欢：$liked',
                  textScaleFactor: 0.9,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '被关注：$followed',
                  textScaleFactor: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//发现页面的原则卡片
class AvatarAndPersonalMessageCard extends StatelessWidget {
  AvatarAndPersonalMessageCard({
    Key key,
    this.thumbnail, //图片
    this.nick_name,
    this.personal_message,
    this.liked,
    this.followed,
    this.principle_text,
    this.principle_description,
  }) : super(key: key);
  final Widget thumbnail;
  final String nick_name;
  final String personal_message;
  final int liked;
  final int followed;
  final String principle_text;
  final String principle_description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'PrincipleView2', arguments: '');
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  _AvatarAndNickName(
                    thumbnail: thumbnail,
                    nick_name: nick_name,
                    personal_message: personal_message,
                    liked: liked,
                    followed: followed,
                  ),
                  SizedBox(
                    child: SmallPrincipleDescription(
                      principle_description: principle_description,
                      principle_text: principle_text,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PersonCard extends StatelessWidget {
  PersonCard({
    Key key,
    this.thumbnail, //图片
    this.nick_name,
    this.personal_message,
    this.followed,
  }) : super(key: key);
  final Widget thumbnail;
  final String nick_name;
  final String personal_message;
  final int followed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'PrincipleView2', arguments: '');
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: _PersonalTile(
                thumbnail: thumbnail,
                nick_name: nick_name,
                personal_message: personal_message,
                followed: followed,
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
          principle_text: '成为超级现实主义的人',
          principle_description: '成功达到目标的人必须明白真实的因果关系，而理想主义者只创造问题，而不是推动进步。',
          liked: 100,
          followed: 30,
        ),
      ],
    );
  }
}

class _PersonalTile extends StatelessWidget {
  _PersonalTile({
    Key key,
    this.thumbnail, //图片

    this.nick_name,
    this.personal_message,
    this.followed,
  }) : super(key: key); //constructor?
  final Widget thumbnail;
  final String nick_name;
  final String personal_message;
  final int followed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Align(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: thumbnail,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$nick_name',
                  textScaleFactor: 1.4,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$personal_message',
                  textScaleFactor: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '被关注：$followed',
                  textScaleFactor: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
