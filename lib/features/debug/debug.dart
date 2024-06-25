import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/booster_item_cubit.dart';
import 'package:pushup_bro/core/cubit/day_cubit.dart';
import 'package:pushup_bro/core/cubit/day_state.dart';
import 'package:pushup_bro/core/cubit/db_cubit.dart';
import 'package:pushup_bro/core/cubit/feature_switch_cubit.dart';
import 'package:pushup_bro/core/cubit/feature_switch_state.dart';
import 'package:pushup_bro/core/cubit/game_inventory_cubit.dart';
import 'package:pushup_bro/core/cubit/shared_preferences_cubit.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/booster_items.dart';
import 'package:pushup_bro/core/model/feature_variants.dart';
import 'package:pushup_bro/core/model/pushup.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';
import 'package:pushup_bro/core/provider/local_notification_provider.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/news_cubit.dart';

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
    await dbCubit.wipePushups();
  }

  Future<void> resetItems() async =>
      context.read<BoosterItemCubit>().resetItems();

  Future<void> wipeUser() async => context.read<DBCubit>().wipeUser();

  void addBoosterItem() => context.read<BoosterItemCubit>().addItems(
        item: BoosterItems.doublePoints,
        amount: 1,
      );

  void addFriendShareItem() => context.read<BoosterItemCubit>().addItems(
        item: BoosterItems.friendBoost,
        amount: 1,
      );

  void add100Bananas() => context.read<GameInventoryCubit>().updateInventory(
        context.read<GameInventoryCubit>().state.inventory.copyWith(
              bananas:
                  context.read<GameInventoryCubit>().state.inventory.bananas +
                      100,
            ),
      );

  void switchToHookModel() => context.read<FeatureSwitchCubit>().switchFeature(
        FeatureVariants.hookmodel,
      );

  Future<void> switchToGamified() async {
    final sharedPrefsCubit = context.read<SharedPreferencesCubit>();
    final featuredSwitchCubit = context.read<FeatureSwitchCubit>();
    await sharedPrefsCubit.setFirstTimeIslandVisited(isFirstVisit: true);
    featuredSwitchCubit.switchFeature(
      FeatureVariants.gamification,
    );
  }

  Future<void> addDay() async {
    final dayCubit = context.read<DayCubit>()..increment();
    final newsCubit = context.read<NewsCubit>();
    final boosterItemCubit = context.read<BoosterItemCubit>();
    final featureVariantState = context.read<FeatureSwitchCubit>().state;
    final day = dayCubit.state.day;

    await newsCubit.getNews(day);
    boosterItemCubit.fetchItems(day);

    if (day == 2 && featureVariantState is FeatureSwitchStateHookmodel) {
      Future.delayed(
        const Duration(seconds: 3),
        () => showLocalNotification(
          title: 'A challenge awaits you',
          body: 'Your friend Lucas has asked you to continue the streak',
        ),
      );
    }
  }

  Future<void> resetDay() async {
    final sharedPrefsCubit = context.read<SharedPreferencesCubit>();
    final dayCubit = context.read<DayCubit>()..reset();
    final day = dayCubit.state.day;
    final newsCubit = context.read<NewsCubit>();
    final boosterItemCubit = context.read<BoosterItemCubit>();

    await newsCubit.getNews(day);
    boosterItemCubit.fetchItems(day);
    await sharedPrefsCubit.setFirstTimeIslandVisited(isFirstVisit: true);
    await wipeUser();
    await resetPushups();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 64),
                Text(
                  'General App Debug',
                  style: context.textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                BlocBuilder<DayCubit, DayState>(
                  builder: (context, state) => Text(
                    'Current day ${state.day}',
                    style: context.textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 12),
                PBButton(
                  'Add day',
                  callback: addDay,
                  expanded: true,
                ),
                const SizedBox(height: 12),
                PBButton(
                  'Reset day',
                  callback: resetDay,
                  expanded: true,
                ),
                const SizedBox(height: 12),
                BlocBuilder<FeatureSwitchCubit, FeatureSwitchState>(
                  builder: (context, state) => Text(
                    'Current app ${state.featureVariant.name}',
                    style: context.textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 12),
                PBButton(
                  'Switch to hook model',
                  callback: switchToHookModel,
                  expanded: true,
                ),
                const SizedBox(height: 12),
                PBButton(
                  'Switch to gamified app',
                  callback: switchToGamified,
                  expanded: true,
                ),
                const SizedBox(height: 32),
                Text(
                  'Hook Model Debug',
                  style: context.textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
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
                  callback: wipeUser,
                  expanded: true,
                ),
                const SizedBox(height: 12),
                PBButton(
                  'Add Booster Item',
                  callback: addBoosterItem,
                  expanded: true,
                ),
                const SizedBox(height: 12),
                PBButton(
                  'Add Friendshare Item',
                  callback: addFriendShareItem,
                  expanded: true,
                ),
                const SizedBox(height: 12),
                PBButton(
                  'Reset items',
                  callback: resetItems,
                  expanded: true,
                ),
                const SizedBox(height: 32),
                Text(
                  'Gamification Debug',
                  style: context.textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                PBButton(
                  'Add 100 Bananas',
                  callback: add100Bananas,
                  expanded: true,
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      );
}
