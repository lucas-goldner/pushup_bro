import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/shared_preferences/shared_preferences_cubit.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/model/pushup_set.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';
import 'package:pushup_bro/ui/widgets/common/pb_button.dart';
import 'package:pushup_bro/ui/widgets/home/finished_set_stats_item.dart';

class FinishedSetBottomSheet extends StatefulWidget {
  const FinishedSetBottomSheet(this.pushupSet, {super.key});
  final PushupSet pushupSet;

  @override
  State<FinishedSetBottomSheet> createState() => _FinishedSetBottomSheetState();
}

class _FinishedSetBottomSheetState extends State<FinishedSetBottomSheet> {
  double currentSliderValue = 0;

  Future<void> closeModal() async => Navigator.of(context).pop(
        await BlocProvider.of<SharedPreferencesCubit>(context)
            .getFirstPushupCompleted(),
      );

  @override
  Widget build(BuildContext context) {
    final localized = S.of(context);

    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                localized.congrats,
                style: PBTextStyles.pageTitleTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                localized.difficulty,
                style: PBTextStyles.headerTextStyle,
              ),
            ),
            Slider(
              value: currentSliderValue,
              activeColor: PBColors.accentColor,
              inactiveColor: PBColors.secondaryColor,
              max: 5,
              divisions: 5,
              label: currentSliderValue.round().toString(),
              onChanged: (value) => setState(() => currentSliderValue = value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  S.of(context).easyDifficulty,
                  style: PBTextStyles.defaultTextStyle,
                ),
                Text(
                  S.of(context).middleDifficulty,
                  style: PBTextStyles.defaultTextStyle,
                ),
                Text(
                  S.of(context).hardDifficulty,
                  style: PBTextStyles.defaultTextStyle,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: Text(
                S.of(context).stats,
                style: PBTextStyles.headerTextStyle,
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
                      text: S.of(context).completedInXMinutes(
                            widget.pushupSet.timeSpent.toString(),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: FinishedSetStatsItem(
                      icon: CarbonIcons.add_alt,
                      text: S.of(context).madeXPushups(
                            widget.pushupSet.pushups.length.toString(),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: FinishedSetStatsItem(
                      icon: CarbonIcons.chart_average,
                      text: S.of(context).onAverage(
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
              callback: closeModal,
            ),
          ],
        ),
      ),
    );
  }
}
