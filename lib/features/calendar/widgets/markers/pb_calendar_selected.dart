import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

class PBCalendarSelected extends StatelessWidget {
  const PBCalendarSelected(this.day, {super.key});
  final DateTime day;

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(40),
            ),
            border: Border.all(
              width: 2,
              color: context.colorScheme.inversePrimary,
            ),
          ),
          child: Center(
            child: Text(
              DateFormat.d().format(day),
              style: context.textTheme.bodyMedium,
            ),
          ),
        ),
      );
}
