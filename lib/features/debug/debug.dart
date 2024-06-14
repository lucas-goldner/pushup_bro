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
      List<Pushup>.generate(
        math.Random().nextInt(40),
        (index) => Pushup(
          completedAt: DateTime(
            2024,
            math.Random().nextInt(12),
            math.Random().nextInt(30),
          ),
        ),
      ),
      math.Random().nextInt(5),
    );

    await context.read<DBCubit>().writeNewPushupsetToDB(pushupSet);
  }

  Future<void> resetPushups() async {
    final dbCubit = context.read<DBCubit>();
    final pushups = await context.read<DBCubit>().getAllPushupSets();
    final pushupIds = pushups.map((e) => e.id).toList();
    for (final id in pushupIds) {
      await dbCubit.deletePushupSetFromDB(id);
    }
  }

  Future<void> wiperUser() async => context.read<DBCubit>().wipeUser();

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
                expanded: true,
              ),
              const SizedBox(height: 12),
              PBButton(
                'Reset pushups',
                callback: resetPushups,
                expanded: true,
              ),
              const SizedBox(height: 12),
              PBButton(
                'Wiper user',
                callback: wiperUser,
                expanded: true,
              ),
            ],
          ),
        ),
      );
}
