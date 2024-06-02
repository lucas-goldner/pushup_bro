import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pushup_bro/core/style/pb_colors.dart';
import 'package:pushup_bro/core/style/pb_text_styles.dart';

class PBCalendarSelectedMarker extends StatelessWidget {
  const PBCalendarSelectedMarker(this.day, {super.key});
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
          border: Border.all(
            width: 2,
            color: PBColors.accentColor,
          ),
        ),
        child: Center(
          child: Text(
            DateFormat.d().format(day),
            style: PBTextStyles.defaultTextStyle,
          ),
        ),
      ),
    );
  }
}
