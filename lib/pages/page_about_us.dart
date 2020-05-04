import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '关于我们',
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: ListView(
          children: <Widget>[
            // Column(
            //   children: <Widget>[
            //     Row(
            //       children: <Widget>[
            //         AspectRatio(
            //           aspectRatio: 1,
            //           child: InkWell(
            //             onTap: () {
            //               //TODO
            //             },
            //             child: Container(
            //              // height: 60,
            //               decoration: BoxDecoration(
            //                 image: DecorationImage(
            //                     image: AssetImage('lib/assets/avatar/1.png')),
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //           ),
            //         ),
            //         AspectRatio(
            //           aspectRatio: 1,
            //           child: InkWell(
            //             onTap: () {
            //               //TODO
            //             },
            //             child: Container(
            //              // height: 60,
            //               decoration: BoxDecoration(
            //                 image: DecorationImage(
            //                     image: AssetImage('lib/assets/avatar/2.png')),
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: <Widget>[
            //         AspectRatio(
            //           aspectRatio: 1,
            //           child: InkWell(
            //             onTap: () {
            //               //TODO
            //             },
            //             child: Container(
            //               //height: 60,
            //               decoration: BoxDecoration(
            //                 image: DecorationImage(
            //                     image: AssetImage('lib/assets/avatar/3.png')),
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //           ),
            //         ),
            //         AspectRatio(
            //           aspectRatio: 1,
            //           child: InkWell(
            //             onTap: () {
            //               //TODO
            //             },
            //             child: Container(
            //              // height: 60,
            //               decoration: BoxDecoration(
            //                 image: DecorationImage(
            //                     image: AssetImage('lib/assets/avatar/4.png')),
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: <Widget>[
            //         AspectRatio(
            //           aspectRatio: 1,
            //           child: InkWell(
            //             onTap: () {
            //               //TODO
            //             },
            //             child: Container(
            //              // height: 60,
            //               decoration: BoxDecoration(
            //                 image: DecorationImage(
            //                     image: AssetImage('lib/assets/avatar/5.png')),
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //           ),
            //         ),
            //         AspectRatio(
            //           aspectRatio: 1,
            //           child: InkWell(
            //             onTap: () {
            //               //TODO
            //             },
            //             child: Container(
            //             //  height: 60,
            //               decoration: BoxDecoration(
            //                 image: DecorationImage(
            //                     image: AssetImage('lib/assets/avatar/6.png')),
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 200,
                  child: Text(
                    '''
    希望大家和我一样，把自己的失败经验，失败的人生，一字一句，仔仔细细的总结起来，和盘托出，毫无保留的，实名制的告诉全世界，告诉世界上的每一个人。    ————曾博                ''',
                    maxLines: 999,
                    textScaleFactor: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.contact_mail,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '联系邮箱',
                        textScaleFactor: 0.7,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 100,
                  ),
                ),
                Expanded(flex: 4, child: Text('3100628889@qq.com'))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '地址',
                        textScaleFactor: 0.7,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 100,
                  ),
                ),
                Expanded(flex: 4, child: Text('广州'))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.update,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '版本号',
                        textScaleFactor: 0.7,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 100,
                  ),
                ),
                Expanded(flex: 4, child: Text('1.0'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 40, 20, 30),
                  child: Text(
                    'app intro',
                    textScaleFactor: 2,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    '''
    We provide a platform for people to find and share the failures they experienced during the trip toward success, toward transcending themselves, or simply toward a peaceful mind. We hope this platform can accelerate your evolution.
                    ''',
                    maxLines: 999,
                    textScaleFactor: 1,
                  ),
                ),
              ],
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Padding(
            //       padding: EdgeInsets.fromLTRB(30, 40, 20, 30),
            //       child: Text(
            //         '用户协议',
            //         textScaleFactor: 2,
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Container(
            //       width: MediaQuery.of(context).size.width - 100,
            //       child: Text(
            //         '''
            //         Lorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam maecenas ligula nostra, accumsan taciti. Sociis mauris in integer, a dolor netus non dui aliquet, sagittis felis sodales, dolor sociis mauris, vel eu libero cras. Faucibus at. Arcu habitasse elementum est, ipsum purus pede porttitor class, ut adipiscing, aliquet sed auctor, imperdiet arcu per diam dapibus libero duis. Enim eros in vel, volutpat nec pellentesque leo, temporibus scelerisque nec.
            //         Ac dolor ac adipiscing amet bibendum nullam, lacus molestie ut libero nec, diam et, pharetra sodales, feugiat ullamcorper id tempor id vitae. Mauris pretium aliquet, lectus tincidunt. Porttitor mollis imperdiet libero senectus pulvinar. Etiam molestie mauris ligula laoreet, vehicula eleifend. Repellat orci erat et, sem cum, ultricies sollicitudin amet eleifend dolor nullam erat, malesuada est leo ac. Varius natoque turpis elementum est. Duis montes, tellus lobortis lacus amet arcu et. In vitae vel, wisi at, id praesent bibendum libero faucibus porta egestas, quisque praesent ipsum fermentum tempor. Curabitur auctor, erat mollis sed, turpis vivamus a dictumst congue magnis. Aliquam amet ullamcorper dignissim molestie, mollis. Tortor vitae tortor eros wisi facilisis.
            //         Consectetuer arcu ipsum ornare pellentesque vehicula, in vehicula diam, ornare magna erat felis wisi a risus. Justo fermentum id. Malesuada eleifend, tortor molestie, a a vel et. Mauris at suspendisse, neque aliquam faucibus adipiscing, vivamus in. Wisi mattis leo suscipit nec amet, nisl fermentum tempor ac a, augue in eleifend in venenatis, cras sit id in vestibulum felis in, sed ligula. In sodales suspendisse mauris quam etiam erat, quia tellus convallis eros rhoncus diam orci, porta lectus esse adipiscing posuere et, nisl arcu vitae laoreet. Morbi integer molestie, amet suspendisse morbi, amet maecenas, a maecenas mauris neque proin nisl mollis. Suscipit nec ligula ipsum orci nulla, in posuere ut quis ultrices, lectus primis vehicula velit hasellus lectus, vestibulum orci laoreet inceptos vitae, at consectetuer amet et consectetuer. Congue porta scelerisque praesent at, lacus vestibulum et at dignissim cras urna, ante convallis turpis duis lectus sed aliquet, at et ultricies. Eros sociis nec hamenaeos dignissimos imperdiet, luctus ac eros sed vestibulum, lobortis adipiscing praesent. Nec eros eu ridiculus libero felis.
            //         Donec arcu risus diam amet sit. Congue tortor risus vestibulum commodo nisl, luctus augue amet quis aenean maecenas sit, donec velit iusto, morbi felis elit et nibh. Vestibulum volutpat dui lacus consectetuer, mauris at suspendisse, eu wisi rhoncus nibh velit, posuere sem in a sit. Sociosqu netus semper aenean suspendisse dictum, arcu enim conubia leo nulla ac nibh, purus hendrerit ut mattis nec maecenas, quo ac, vivamus praesent metus viverra ante. Natoque sed sit hendrerit, dapibus velit molestiae leo a, ut lorem sit et lacus aliquam. Sodales nulla ante auctor excepturi wisi, dolor lacinia dignissim eros condimentum dis pellentesque, sodales lacus nunc, feugiat at. In orci ligula suscipit luctus, sed dolor eleifend aliquam dui, ut diam mauris, sollicitudin sed nisl lacus.
            //         ''',
            //         maxLines: 999,
            //         textScaleFactor: 1,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
