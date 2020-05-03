// import 'dart:html';

import 'package:flutter/material.dart';
import 'widget_principle_card.dart';

//个人基本数据结构
class NameAnduserIdentity {
  NameAnduserIdentity({
    this.uuid,
    this.userName,
    this.userIdentity,
  });
  String uuid;
  @required
  String userName;
  String userIdentity;
}

//头像昵称签名和关注的一小条个人信息结构
class PersonTileData {
  PersonTileData({
    this.uuid,
    this.userName,
    this.userIdentity,
    this.followed,
    this.avatarId,
  });
  String uuid;
  @required
  String userName;
  String userIdentity;
  int followed;
  int avatarId;
  PersonTileData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userName = json['userName'];
    userIdentity = json['userIdentity'];
    followed = int.parse(json['followed']);
    avatarId = int.parse(json['avatarId']) ;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['userName'] = this.userName;
    data['userIdentity'] = this.userIdentity;
    data['followed'] = this.followed;
    data['avatarId'] = this.avatarId;
    return data;
  }
}


//头像昵称签名和关注的一小条个人信息还会显示认证信息(小号)
class SmallPersonalTile extends StatelessWidget {
  SmallPersonalTile({
    Key key,
    this.uuid,
    this.userName,
    this.userIdentity,
    this.followed,
    this.avatarId,
  }) : super(key: key);
  String uuid;
  @required
  String userName;
  String userIdentity;
  int followed;
  int avatarId;

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
                  child: Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('lib/assets/avatar/$avatarId.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
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
                  '$userName',
                  textScaleFactor: 0.9,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$userIdentity',
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
          Icon(
            Icons.verified_user,
            size: 15,
            color: userIdentity == '' || userIdentity == null
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
          ),
          Expanded(
            flex: 2,
            child: Text(
              '被关注：$followed',
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
    );
  }
}

//发现页面的原则卡片（个人信息+1条原则）
class DiscoverPrincipleCard extends StatelessWidget {
  DiscoverPrincipleCard(
      {Key key,
      this.uuid,
      this.userName,
      this.userIdentity,
      this.followed,
      this.avatarId,
      this.principleText,
      this.principleDescription});
  String uuid;
  @required
  String userName;
  String userIdentity;
  int followed;
  int avatarId;
  @override
  String principleText;
  String principleDescription;
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
                  SmallPersonalTile(
                    userName: userName,
                    avatarId: avatarId,
                    userIdentity: userIdentity,
                    followed: followed,
                    uuid: uuid,
                  ),
                  SizedBox(
                    child: SmallPrincipleDescription(
                      principleDescription: principleDescription,
                      principleText: principleText,
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

//比较大的显示人个人信息的卡片，比_AvatarAndNickName大
class PersonCard extends StatelessWidget {
  PersonCard({
    Key key,
    this.uuid,
    this.userName,
    this.userIdentity,
    this.followed,
    this.thumbnail,
  });
  String uuid;
  @required
  String userName;
  String userIdentity;
  int followed;
  Widget thumbnail;
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
              child: BigPersonalTile(),
            ),
          ),
        ),
      ),
    );
  }
}

class DiscoverPrincipleScrollView extends StatelessWidget {
  DiscoverPrincipleScrollView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        DiscoverPrincipleCard(
          userIdentity: '成为超级现实主义的人',
          userName: '北大教授王铁崖',
          followed: 30,
          avatarId: 1,
          principleText: 'Principle',
          principleDescription: '成功达到目标的人必须明白真实的因果关系，而理想主义者只创造问题，而不是推动进步。',
        ),
      ],
    );
  }
}

//头像昵称签名和关注的一小条个人信息还会显示认证信息(大号)
class BigPersonalTile extends StatelessWidget {
  BigPersonalTile({
    Key key,
    this.uuid,
    this.userName,
    this.userIdentity,
    this.followed,
    this.thumbnail,
  });
  String uuid;
  @required
  String userName;
  String userIdentity;
  int followed;
  Widget thumbnail;
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
                  '$userName',
                  textScaleFactor: 1.4,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$userIdentity',
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
          Icon(
            Icons.verified_user,
            size: 15,
            color: userIdentity == '' || userIdentity == null
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
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
