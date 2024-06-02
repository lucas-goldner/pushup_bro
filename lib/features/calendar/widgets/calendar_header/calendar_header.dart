import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pushup_bro/core/style/pb_text_styles.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader(this.day, {super.key});
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        DateFormat.yMMMM().format(day),
        style: PBTextStyles.headerTextStyle,
      ),
    );
  }
}
