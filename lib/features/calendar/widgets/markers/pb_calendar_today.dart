import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

class PBCalendarToday extends StatelessWidget {
  const PBCalendarToday(this.day, {super.key});
  final DateTime day;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.colorScheme.onSecondary,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            DateFormat.d().format(day),
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.surface,
            ),
          ),
        ),
      );
}
