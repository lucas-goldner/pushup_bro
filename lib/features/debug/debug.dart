import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/db_cubit.dart';
import 'package:pushup_bro/core/model/pushup.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';

class Debug extends StatefulWidget {
  const Debug({super.key});
  static const routeName = '/debug';

  @override
  State<Debug> createState() => _DebugState();
}

class _DebugState extends State<Debug> {
  Future<void> addPushups() async {
    final pushupSet = PushupSet(
      effort: math.Random().nextInt(5),
      pushups: List<Pushup>.generate(
        math.Random().nextInt(40),
        (index) => Pushup(
          completedAt: DateTime(
            2024,
            math.Random().nextInt(12),
            math.Random().nextInt(30),
          ),
        ),
      ),
    );

    await context.read<DBCubit>().writeNewPushupsetToDB(pushupSet);
    final newPushups = await context.read<DBCubit>().getAllPushupSets();
    print(newPushups);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 64),
              PBButton(
                'Add pushups',
                callback: addPushups,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      );
}
