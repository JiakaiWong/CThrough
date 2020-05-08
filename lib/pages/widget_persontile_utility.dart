// import 'dart:html';
import 'package:date_matching/pages/widget_edit_goal_utility.dart';
import 'package:date_matching/pages/widget_edit_principle_utility.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List listOfOthersPersonTileData = List<PersonTileData>();
List listOfMyFollowingUuid = List<String>();

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
    avatarId = int.parse(json['avatarId']);
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

//别人的目标卡片
class TheirPersonTileWithGoal extends StatelessWidget {
  Future<Null> changeCurrentViewingPerson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentViewingPerson', "$uuid");
  }

  TheirPersonTileWithGoal({
    Key key,
    this.uuid,
    this.userName,
    this.userIdentity,
    this.followed,
    this.avatarId,
    this.goal_setted,
    this.problems_identified,
    this.root_causes_identified,
    this.plan_designed,
    this.action_performed,
  }) : super(key: key);
  String uuid;
  String userName;
  String userIdentity;
  int followed;
  int avatarId;
  final String goal_setted;
  final String problems_identified;
  final String root_causes_identified;
  final String plan_designed;
  final String action_performed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: () {
            print('进入别人的信息界面');
            changeCurrentViewingPerson().then((response) {
              Navigator.pushNamed(context, 'OtherPeopleDocumentPage');
            }).then((response) {
              print('跳转');
            });
          },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BarePersonalTile(
                    uuid: uuid,
                    userName: userName,
                    userIdentity: userIdentity,
                    followed: followed,
                    avatarId: avatarId,
                  ),
                  MiniFiveStep(
                    goal_setted: goal_setted,
                    problems_identified: problems_identified,
                    root_causes_identified: root_causes_identified,
                    plan_designed: plan_designed,
                    action_performed: action_performed,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

//别人的目标卡片
class TheirPersonTileWithPrinciple extends StatelessWidget {
  Future<Null> changeCurrentViewingPerson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentViewingPerson', "$uuid");
  }

  TheirPersonTileWithPrinciple({
    Key key,
    this.uuid,
    this.userName,
    this.userIdentity,
    this.followed,
    this.avatarId,
    this.principleText,
    this.principleDescription,
  }) : super(key: key);
  String uuid;
  String userName;
  String userIdentity;
  int followed;
  int avatarId;
  final String principleText;
  final String principleDescription;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: () {
            print('进入别人的信息界面');
            changeCurrentViewingPerson().then((response) {
              Navigator.pushNamed(context, 'OtherPeopleDocumentPage');
            }).then((response) {
              print('跳转');
            });
          },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BarePersonalTile(
                    uuid: uuid,
                    userName: userName,
                    userIdentity: userIdentity,
                    followed: followed,
                    avatarId: avatarId,
                  ),
                  FullPrincipleDescription(
                    principleText: principleText,
                    principleDescription: principleDescription,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

//别人的个人信息卡片
class TheirPersonTile extends StatelessWidget {
  Future<Null> changeCurrentViewingPerson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentViewingPerson', "$uuid");
  }

  TheirPersonTile({
    Key key,
    this.uuid,
    this.userName,
    this.userIdentity,
    this.followed,
    this.avatarId,
  }) : super(key: key);
  String uuid;
  String userName;
  String userIdentity;
  int followed;
  int avatarId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: () {
            print('进入别人的信息界面');
            changeCurrentViewingPerson().then((response) {
              Navigator.pushNamed(context, 'OtherPeopleDocumentPage');
            }).then((response) {
              print('跳转');
            });
          },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BigPersonalTile(
                uuid: uuid,
                userName: userName,
                userIdentity: userIdentity,
                followed: followed,
                avatarId: avatarId,
              )),
        ),
      ),
    );
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
                        image:
                            new AssetImage('lib/assets/avatar/$avatarId.jpg'),
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

//无边框
class BarePersonalTile extends StatelessWidget {
  BarePersonalTile({
    Key key,
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
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Container(
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image:
                            new AssetImage('lib/assets/avatar/$avatarId.jpg'),
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

//头像昵称签名和关注的一小条个人信息还会显示认证信息(大号)
class BigPersonalTile extends StatelessWidget {
  BigPersonalTile({
    Key key,
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    child: Container(
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image:
                              new AssetImage('lib/assets/avatar/$avatarId.jpg'),
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
      ),
    );
  }
}
