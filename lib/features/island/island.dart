import 'package:flutter/material.dart';
import 'package:pushup_bro/features/island/widgets/sand.dart';
import 'package:pushup_bro/features/island/widgets/walking_monkey.dart';

class Island extends StatefulWidget {
  const Island({super.key});
  static const routeName = '/island';

  @override
  State<Island> createState() => _IslandState();
}

class _IslandState extends State<Island> {
  @override
  Widget build(BuildContext context) => const Stack(
        children: [
          Sand(),
          WalkingMonkey(),
        ],
      );
}
