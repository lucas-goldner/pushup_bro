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
import 'package:pushup_bro/features/pushup_tracking/widgets/finished_set_stats_item.dart';

class FinishedSetBottomSheet extends StatefulWidget {
  const FinishedSetBottomSheet(this.pushupSet, {super.key});
  final PushupSet pushupSet;

  @override
  State<FinishedSetBottomSheet> createState() => _FinishedSetBottomSheetState();
}

class _FinishedSetBottomSheetState extends State<FinishedSetBottomSheet> {
  double currentSliderValue = 0;

  Future<void> savePushupSet() async {
    await BlocProvider.of<DBCubit>(context).writeNewPushupsetToDB(
      widget.pushupSet.copyWith(effort: currentSliderValue.toInt()),
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

  void closeModal() {
    showCupertinoDialog<Widget>(
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
  }

  @override
  Widget build(BuildContext context) {
    final localized = context.l10n;

    return Material(
      child: SafeArea(
        child: Column(
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
              value: currentSliderValue,
              activeColor: context.colorScheme.inversePrimary,
              inactiveColor: context.colorScheme.secondary,
              max: 5,
              divisions: 5,
              label: currentSliderValue.round().toString(),
              onChanged: (value) => setState(() => currentSliderValue = value),
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
            const SizedBox(
              height: 20,
            ),
            PBButton(
              localized.saveSet,
              callback: closeModalAndSave,
            ),
          ],
        ),
      ),
    );
  }
}
