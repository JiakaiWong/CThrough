// import 'dart:html';

import 'package:flutter/material.dart';
import 'principle_card.dart';

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
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '被喜欢：$liked',
                textScaleFactor: 0.9,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
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
    this.SmallPrincipleDescription,
  }) : super(key: key);
  final Widget thumbnail;
  final String nick_name;
  final String personal_message;
  final int liked;
  final int followed;
  final Widget SmallPrincipleDescription;
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'PrincipleView2');
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
                Expanded(
                    flex: 10,
                    child: SizedBox(
                      child: SmallPrincipleDescription,
                    ))
              ],
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
          SmallPrincipleDescription: SmallPrincipleDescription(
          principle_text: '成为超级现实主义的人',
          principle_description: '成功达到目标的人必须明白真实的因果关系，而理想主义者只创造问题，而不是推动进步。',
        ),
          liked: 100,
          followed: 30,
        ),
      ],
    );
  }
}
