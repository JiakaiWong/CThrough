import 'package:flutter/material.dart';

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.preferredPlaceOfTheCard,
    this.preferredTimeOfTheCard,
    this.invitationSenderOfTheCard,
    this.firstPreferenceOfTheCard,
    this.secondPreferenceOfTheCard,
    
  }) : super(key: key); //constructor?

  final String preferredPlaceOfTheCard;
  final String preferredTimeOfTheCard;
  final String invitationSenderOfTheCard;
  final String firstPreferenceOfTheCard;
  final String secondPreferenceOfTheCard;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$preferredPlaceOfTheCard',
                textScaleFactor: 2.2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$preferredTimeOfTheCard',
                textScaleFactor: 1.5,
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
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$invitationSenderOfTheCard',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                '详情：$firstPreferenceOfTheCard · $secondPreferenceOfTheCard',
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

class InvitationCard extends StatelessWidget {
  InvitationCard({
    Key key,
    this.thumbnail,//图片
    this.preferredPlaceOfTheCard,//想去的地方
    this.preferredTimeOfTheCard,//时间
    this.invitationSenderOfTheCard,//用户名
    this.firstPreferenceOfTheCard,//第一偏好
    this.secondPreferenceOfTheCard,//第二偏好
    
  }) : super(key: key);

  final Widget thumbnail;
  final String preferredPlaceOfTheCard;
  final String preferredTimeOfTheCard;
  final String invitationSenderOfTheCard;
  final String firstPreferenceOfTheCard;
  final String secondPreferenceOfTheCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.75,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  preferredPlaceOfTheCard: preferredPlaceOfTheCard,
                  preferredTimeOfTheCard: preferredTimeOfTheCard,
                  invitationSenderOfTheCard: invitationSenderOfTheCard,
                  firstPreferenceOfTheCard: firstPreferenceOfTheCard,
                  secondPreferenceOfTheCard: secondPreferenceOfTheCard,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InvitationCardScrollView extends StatelessWidget {
  InvitationCardScrollView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        InvitationCard(
          thumbnail: Container(
            decoration: const BoxDecoration(color: Colors.deepOrange),
          ),
          preferredPlaceOfTheCard: '看个剧',
          preferredTimeOfTheCard: '玩一天',
          invitationSenderOfTheCard: '喜欢帅的',
          firstPreferenceOfTheCard: '180+',
          secondPreferenceOfTheCard: '。',
        ),
        InvitationCard(
          thumbnail: Container(
            decoration: const BoxDecoration(color: Colors.pinkAccent),
          ),
          preferredPlaceOfTheCard: '随便逛逛',
          preferredTimeOfTheCard: '晚上',
          invitationSenderOfTheCard: '华工程序猿',
          firstPreferenceOfTheCard: '颜值中上',
          secondPreferenceOfTheCard: '穷游',
        ),
        InvitationCard(
            thumbnail: Container(
              decoration: const BoxDecoration(color: Colors.green),
            ),
            preferredPlaceOfTheCard: '穗石村海鲜大排档',
            preferredTimeOfTheCard: '晚上',
            invitationSenderOfTheCard: '卢本伟准备就绪！！',
            firstPreferenceOfTheCard: '可爱的美少女',
            secondPreferenceOfTheCard: '安徽老乡有没有？',
          ),
          InvitationCard(
            thumbnail: Container(
              decoration: const BoxDecoration(color: Colors.blueAccent),
            ),
            preferredPlaceOfTheCard: '看个电影',
            preferredTimeOfTheCard: '4月25或26的晚上',
            invitationSenderOfTheCard: '我是用户名',
            firstPreferenceOfTheCard: '男的',
            secondPreferenceOfTheCard: '穷游',
          ),
      ],
    );
  }
}