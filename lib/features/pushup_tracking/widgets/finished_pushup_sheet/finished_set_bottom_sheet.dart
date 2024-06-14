import 'dart:ui';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/db_cubit.dart';
import 'package:pushup_bro/core/cubit/db_state.dart';
import 'package:pushup_bro/core/cubit/shared_preferences_cubit.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';
import 'package:pushup_bro/core/model/user.dart';
import 'package:pushup_bro/core/style/pb_colors.dart';
import 'package:pushup_bro/core/style/pb_text_styles.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/features/progress/model/level_scalings.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/finished_pushup_sheet/finished_set_stats_item.dart';

class FinishedSetBottomSheet extends StatefulWidget {
  const FinishedSetBottomSheet(this.pushupSet, {super.key});
  final PushupSet pushupSet;

  @override
  State<FinishedSetBottomSheet> createState() => _FinishedSetBottomSheetState();
}

class _FinishedSetBottomSheetState extends State<FinishedSetBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double difficultySliderValue = 0;
  bool levelUpVisible = false;
  int level = 1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    final amountOfXP = widget.pushupSet.pushups.length * 2;
    final user = BlocProvider.of<DBCubit>(context).state.user;
    level = user.level;
    final initialScaling = LevelScaler().getCurrentExperienceRelativeToLevel(
      user.level,
      user.xp,
    );
    final levelScaling = LevelScaler().getCurrentExperienceRelativeToLevel(
      user.level,
      user.xp + amountOfXP,
    );

    final levelUps =
        splitDouble(levelScaling).where((element) => element == 1).toList();
    final xpLeftOver =
        splitDouble(levelScaling).where((element) => element != 1).first;

    if (levelUps.isEmpty) {
      _animation = Tween<double>(begin: initialScaling, end: 1)
          .animate(_controller)
        ..addListener(() async => setState(() {}));
      _controller.animateTo(levelScaling, duration: const Duration(seconds: 1));
    } else {
      _animation = Tween<double>(begin: initialScaling, end: 1)
          .animate(_controller)
        ..addListener(() async {
          setState(() {});

          if (_animation.value == 1) {
            level += 1;
            levelUps.remove(levelUps.first);
            showLevelUp();
            _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
            _controller.reset();

            if (levelUps.isEmpty) {
              await _controller.animateTo(
                xpLeftOver,
                duration: const Duration(milliseconds: 500),
              );
            } else if (levelUps.length == 1) {
              await _controller.animateTo(
                1,
                duration: const Duration(seconds: 1),
              );
            } else {
              if (levelUps.isNotEmpty) {
                await _controller.animateTo(
                  1,
                  duration: const Duration(seconds: 1),
                );
              }
            }
          }
        });

      _controller.animateTo(1, duration: const Duration(seconds: 1));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<double> splitDouble(double number) {
    final integerPart = number.floor();
    final fractionalPart = number - integerPart;

    final onesList = List<double>.filled(integerPart, 1, growable: true);

    if (fractionalPart > 0) {
      onesList.add(fractionalPart);
    }

    return onesList;
  }

  void showLevelUp() => setState(() => levelUpVisible = true);

  Future<void> savePushupSet() async {
    await BlocProvider.of<DBCubit>(context).writeNewPushupsetToDB(
      widget.pushupSet.copyWith(effort: difficultySliderValue.toInt()),
    );
  }

  Future<void> closeModalAndSave() async {
    final navigator = Navigator.of(context);
    final sharedPrefsCubit = BlocProvider.of<SharedPreferencesCubit>(context);
    final dbCubit = BlocProvider.of<DBCubit>(context);
    final finished = await sharedPrefsCubit.getFirstPushupCompleted();
    final leftOverXP =
        (LevelScaler().getLevelScaling(level) * _animation.value).toInt();

    if (!finished) {
      await dbCubit.createUser(level: level, xp: leftOverXP);
      await sharedPrefsCubit.finishFirstPushupCompleted();
    } else {
      await dbCubit.updateUser(level: level, xp: leftOverXP);
    }
    await savePushupSet();
    navigator.pop(finished);
  }

  void closeModal() => showCupertinoDialog<Widget>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(context.l10n.closeWithoutSaving),
          content: Text(context.l10n.closeExplanation),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                context.l10n.cancel,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text(
                context.l10n.dontSave,
                style: TextStyle(
                  color: context.colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => {
                Navigator.of(context)
                  ..pop()
                  ..pop(),
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final localized = context.l10n;

    return BlocSelector<DBCubit, DBState, User>(
      selector: (state) => state.user,
      builder: (context, user) {
        return Material(
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: Text(
                            localized.congrats,
                            style: pageTitleTextStyle,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: background2,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: IconButton(
                              onPressed: closeModal,
                              icon: Icon(
                                CarbonIcons.close,
                                color: context.colorScheme.surfaceBright,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        localized.difficulty,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    Slider(
                      value: difficultySliderValue,
                      activeColor: context.colorScheme.inversePrimary,
                      inactiveColor: context.colorScheme.secondary,
                      max: 5,
                      divisions: 5,
                      label: difficultySliderValue.round().toString(),
                      onChanged: (value) =>
                          setState(() => difficultySliderValue = value),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          context.l10n.easyDifficulty,
                          style: context.textTheme.bodyMedium,
                        ),
                        Text(
                          context.l10n.middleDifficulty,
                          style: context.textTheme.bodyMedium,
                        ),
                        Text(
                          context.l10n.hardDifficulty,
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      child: Text(
                        context.l10n.stats,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: FinishedSetStatsItem(
                              icon: CarbonIcons.time,
                              text: context.l10n.completedInXMinutes(
                                widget.pushupSet.timeSpent.toString(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: FinishedSetStatsItem(
                              icon: CarbonIcons.add_alt,
                              text: context.l10n.madeXPushups(
                                widget.pushupSet.pushups.length.toString(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: FinishedSetStatsItem(
                              icon: CarbonIcons.chart_average,
                              text: context.l10n.onAverage(
                                '${widget.pushupSet.pushups.length}/${widget.pushupSet.timeSpent}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text(
                            context.l10n.progress,
                            style: context.textTheme.titleSmall,
                          ),
                          const Spacer(),
                          Text(
                            context.l10n.level(level),
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LinearProgressIndicator(
                        value: _animation.value,
                        backgroundColor: context.colorScheme.surface,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PBButton(
                      localized.saveSet,
                      callback: closeModalAndSave,
                      expanded: true,
                    ),
                  ],
                ),
                Visibility(
                  visible: levelUpVisible,
                  child: Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Center(
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  CarbonIcons.trophy,
                                  size: 100,
                                  color: ternaryColor,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  context.l10n.levelReached(level),
                                  style: context.textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                PBButton(
                                  localized.monkeyConfirm,
                                  callback: () =>
                                      setState(() => levelUpVisible = false),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
