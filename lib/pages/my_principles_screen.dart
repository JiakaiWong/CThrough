import 'package:flutter/material.dart';
import 'utilities/principle_card.dart';

class MyPrinciplesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        // appBar: AppBar(
        //   title: Text('My principles'),
        //   elevation: 0,
        // ),
        body: PrincipleCardScrollView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'NewPrinciple');
          },
          child: Text('添加'),
        ),
      ),
    );
  }
}
