import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';
import 'package:pushup_bro/core/style/pb_colors.dart';
import 'package:pushup_bro/core/style/pb_text_styles.dart';
import 'package:pushup_bro/features/calendar/widgets/calendar_stat_item.dart';
import 'package:pushup_bro/generated/l10n.dart';

class CalendarEvent extends StatelessWidget {
  const CalendarEvent(this.pushupSet, {super.key});
  final PushupSet pushupSet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: background2,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  S.of(context).setOfXOPushups(
                        pushupSet.pushups.length.toString(),
                      ),
                  style: headerTextStyle.copyWith(
                    color: CupertinoColors.white,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  CarbonIcons.fire,
                  color: accentColor,
                ),
                Text(
                  pushupSet.translateEffort(context),
                  style: defaultTextStyle.copyWith(
                    color: CupertinoColors.white,
                  ),
                ),
              ],
            ),
            Text(
              S.of(context).stats,
              style: buttonTextStyle.copyWith(
                color: CupertinoColors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalendarStatItem(
                  pushupSet.timeSpent.toString(),
                  CarbonIcons.time,
                ),
                CalendarStatItem(
                  pushupSet.pushups.length.toString(),
                  CarbonIcons.add_alt,
                ),
                CalendarStatItem(
                  '${pushupSet.pushups.length}/${pushupSet.timeSpent}',
                  CarbonIcons.chart_average,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
