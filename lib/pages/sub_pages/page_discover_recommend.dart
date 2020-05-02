import 'package:flutter/material.dart';
import 'widget_discovery_card.dart';

class DiscoverRecommended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DiscoverPrincipleCard(
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
          liked: 423,
          followed: 12,
        ),
        DiscoverPrincipleCard(
          thumbnail: Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('lib/assets/figure2.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          nick_name: '华工平凡人',
          personal_message: '理解事物的本质，持续进化，影响世界',
          principle_text: '进化是生命最伟大的成就和最丰厚的奖赏',
          principle_description: '个人的目标必须与集体目标一致。客观世界总是趋向于整体优化，而不是个人。频繁的试错中获得的适应力是无价的。一个人总是既伟大又平凡，了解这一点，然后决定你想成为的样子。',
          liked: 213,
          followed: 43,
        ),
        DiscoverPrincipleCard(
          thumbnail: Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('lib/assets/figure3.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          nick_name: '深大一哥',
          personal_message: '被爱，帮助别人，道德上的正确',
          principle_text: '观察客观世界了解事物运作的方式',
          principle_description: '不要拘泥于你所认为事物“应该”如何，因为这样会帮助你你会忘记事物的真相。要想“做好”，一个人必须持续按照自然规律行动',
          liked: 321,
          followed: 99,
        ),
        DiscoverPrincipleCard(
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
          liked: 423,
          followed: 12,
        ),
        DiscoverPrincipleCard(
          thumbnail: Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('lib/assets/figure2.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          nick_name: '华工平凡人',
          personal_message: '理解事物的本质，持续进化，影响世界',
          principle_text: '进化是生命最伟大的成就和最丰厚的奖赏',
          principle_description: '个人的目标必须与集体目标一致。客观世界总是趋向于整体优化，而不是个人。频繁的试错中获得的适应力是无价的。一个人总是既伟大又平凡，了解这一点，然后决定你想成为的样子。',
          liked: 213,
          followed: 43,
        ),
        DiscoverPrincipleCard(
          thumbnail: Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('lib/assets/figure3.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          nick_name: '深大一哥',
          personal_message: '被爱，帮助别人，道德上的正确',
          principle_text: '观察客观世界了解事物运作的方式',
          principle_description: '不要拘泥于你所认为事物“应该”如何，因为这样会帮助你你会忘记事物的真相。要想“做好”，一个人必须持续按照自然规律行动',
          liked: 321,
          followed: 99,
        ),
      ],
    );
  }
}
