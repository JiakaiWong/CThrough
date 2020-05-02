import 'package:flutter/material.dart';

class GoalAndObstacles {
  GoalAndObstacles(this.goal, [this.children = const <GoalAndObstacles>[]]);
  final String goal;
  final List<GoalAndObstacles> children;
}

final List<GoalAndObstacles> goalAndObstaclesDemoData = <GoalAndObstacles>[
  GoalAndObstacles(
    'goal1',
    <GoalAndObstacles>[
      GoalAndObstacles(
        'goal1.1',
        <GoalAndObstacles>[
          GoalAndObstacles(
            'goal1.1.1',
            <GoalAndObstacles>[
              GoalAndObstacles(
                'goal1.1.1.1',
                <GoalAndObstacles>[
                  GoalAndObstacles(
                    'goal1.1.1.1',
                  ),
                ],
              ),
            ],
          ),
          GoalAndObstacles(
            'goal1.1.2',
            <GoalAndObstacles>[],
          ),
        ],
      ),
      GoalAndObstacles(
        'goal1.2',
        <GoalAndObstacles>[
          GoalAndObstacles(
            'goal1.2.1',
            <GoalAndObstacles>[
              GoalAndObstacles(
                'goal1.2.1.1',
                <GoalAndObstacles>[
                  GoalAndObstacles(
                    'goal1.2.1.1.1',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoalAndObstacles(
        'goal1.3',
        <GoalAndObstacles>[
          GoalAndObstacles(
            'goal1.3.1',
            <GoalAndObstacles>[
              GoalAndObstacles(
                'goal1.3.1.1',
                <GoalAndObstacles>[
                  GoalAndObstacles(
                    'goal1.3.1.1.1',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];

class GoalAndObstaclesItem extends StatelessWidget {
  const GoalAndObstaclesItem(this.goalAndObstacles);
  final GoalAndObstacles goalAndObstacles;
  Widget _buildTiles(GoalAndObstacles root) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          leading: Text(
            '目标：',
            textScaleFactor: 0.8,
          ),
          key: PageStorageKey<GoalAndObstacles>(root),
          title: Text(
            root.goal,
            textScaleFactor: 1.6,
          ),
          subtitle: Text(''),
          children: root.children.map(_buildTiles).toList(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(goalAndObstacles);
  }
}
 
class GoalAndObstaclesExtensionListView extends StatefulWidget {
  @override
  _GoalAndObstaclesExtensionListViewState createState() =>
      _GoalAndObstaclesExtensionListViewState();
}

class _GoalAndObstaclesExtensionListViewState
    extends State<GoalAndObstaclesExtensionListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            GoalAndObstaclesItem(goalAndObstaclesDemoData[index]),
        itemCount: goalAndObstaclesDemoData.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
      ),
    );
  }
}
