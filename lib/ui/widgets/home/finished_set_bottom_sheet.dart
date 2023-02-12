import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';
import 'package:pushup_bro/ui/widgets/common/pb_button.dart';
import 'package:pushup_bro/ui/widgets/home/finished_set_stats_item.dart';

class FinishedSetBottomSheet extends StatefulWidget {
  const FinishedSetBottomSheet({super.key});

  @override
  State<FinishedSetBottomSheet> createState() => _FinishedSetBottomSheetState();
}

class _FinishedSetBottomSheetState extends State<FinishedSetBottomSheet> {
  double currentSliderValue = 0;

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
                style: PBTextStyles.boldTextStyle,
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
                      text: S.of(context).completedInXMinutes('3'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: FinishedSetStatsItem(
                      icon: CarbonIcons.add_alt,
                      text: S.of(context).madeXPushups('10'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: FinishedSetStatsItem(
                      icon: CarbonIcons.chart_average,
                      text: S.of(context).onAverage('3/10'),
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
              callback: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
