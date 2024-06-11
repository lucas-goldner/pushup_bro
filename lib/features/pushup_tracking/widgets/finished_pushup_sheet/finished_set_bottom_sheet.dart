import 'dart:ui';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/db_cubit.dart';
import 'package:pushup_bro/core/cubit/shared_preferences_cubit.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';
import 'package:pushup_bro/core/style/pb_colors.dart';
import 'package:pushup_bro/core/style/pb_text_styles.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
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

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() async {
        setState(() {});

        if (_animation.value == 1) {
          await showLevelUp();
        }
      });

    Future.delayed(const Duration(seconds: 1), () => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> showLevelUp() async {
    setState(() => levelUpVisible = true);
  }

  Future<void> savePushupSet() async {
    await BlocProvider.of<DBCubit>(context).writeNewPushupsetToDB(
      widget.pushupSet.copyWith(effort: difficultySliderValue.toInt()),
    );
  }

  Future<void> closeModalAndSave() async {
    final navigator = Navigator.of(context);
    final sharedPrefsCubit = BlocProvider.of<SharedPreferencesCubit>(context);
    await savePushupSet();
    navigator.pop(
      await sharedPrefsCubit.getFirstPushupCompleted(),
    );
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
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
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
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Text(
                    context.l10n.progress,
                    style: context.textTheme.titleSmall,
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
                              context.l10n.levelReached(2),
                              style: context.textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 200,
                              child: PBButton(
                                localized.monkeyConfirm,
                                callback: () => setState(() {
                                  levelUpVisible = false;
                                  _controller
                                    ..reset()
                                    ..animateTo(0.1);
                                }),
                              ),
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
  }
}
