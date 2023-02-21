import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';

class PBCalendarTodayMarker extends StatelessWidget {
  const PBCalendarTodayMarker(this.day, {super.key});
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: PBColors.background2,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          DateFormat.d().format(day),
          style: PBTextStyles.headerTextStyle
              .copyWith(color: CupertinoColors.white),
        ),
      ),
    );
  }
}
