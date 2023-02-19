import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';

class CalendarHeaderDayOfWeek extends StatelessWidget {
  const CalendarHeaderDayOfWeek(this.day, {super.key});
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        DateFormat.E().format(day),
        style: PBTextStyles.headerTextStyle,
      ),
    );
  }
}
