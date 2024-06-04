import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

class PBCalendarDefaultDay extends StatelessWidget {
  const PBCalendarDefaultDay(this.day, {super.key});
  final DateTime day;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          DateFormat.d().format(day),
          style: context.textTheme.bodyMedium,
        ),
      );
}
