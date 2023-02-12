import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
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
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Congrats!',
                style: PBTextStyles.boldTextStyle,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Difficulty',
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
              children: const [
                Text('Easy', style: PBTextStyles.defaultTextStyle),
                Text('Moderate', style: PBTextStyles.defaultTextStyle),
                Text('Difficult', style: PBTextStyles.defaultTextStyle),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: Text(
                'Stats',
                style: PBTextStyles.headerTextStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FinishedSetStatsItem(
                  icon: CarbonIcons.time,
                  text: 'Completed in 3 min',
                ),
                FinishedSetStatsItem(
                  icon: CarbonIcons.add,
                  text: 'Made 30 pushups',
                ),
                FinishedSetStatsItem(
                  icon: CarbonIcons.chart_average,
                  text: 'Did 3 pushups in 5min on average',
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            PBButton(
              'Save Session',
              callback: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
