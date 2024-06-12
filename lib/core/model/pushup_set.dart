import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/extensions/datetime_ext.dart';
import 'package:pushup_bro/core/model/pushup.dart';

part 'pushup_set.g.dart';

@collection
class PushupSet {
  PushupSet({required this.pushups, required this.effort});
  final Id id = Isar.autoIncrement;
  final List<Pushup> pushups;
  final int effort;

  DateTime get startedDate => pushups.first.completedAt ?? DateTime(2000);
  DateTime get completedDate => pushups.last.completedAt ?? DateTime(2000);
  int get timeSpent {
    final difference = completedDate.difference(startedDate).inMinutes;
    return difference == 0 ? 1 : difference;
  }

  String translateEffort(BuildContext context) => switch (effort) {
        0 => context.l10n.noEffort,
        1 => context.l10n.superEasyEffort,
        2 => context.l10n.easyEffort,
        3 => context.l10n.mediumEffort,
        4 => context.l10n.hardEffort,
        5 => context.l10n.superHardEffort,
        _ => context.l10n.noEffort
      };

  PushupSet copyWith({
    List<Pushup>? pushups,
    int? effort,
  }) {
    return PushupSet(
      pushups: pushups ?? this.pushups,
      effort: effort ?? this.effort,
    );
  }
}

extension PushupSetListExtension on List<PushupSet> {
  List<({int month, int pushups})> get stackedPerMonth {
    final pushupsStackedPerMonth = <({int month, int pushups})>[];
    final monthlyPushups = <int, int>{};

    for (final pushupSet in this) {
      for (final pushup in pushupSet.pushups) {
        if (pushup.completedAt != null) {
          final month = pushup.completedAt!.month;
          if (monthlyPushups.containsKey(month)) {
            monthlyPushups[month] = monthlyPushups[month]! + 1;
          } else {
            monthlyPushups[month] = 1;
          }
        }
      }
    }

    monthlyPushups.forEach((month, pushups) {
      pushupsStackedPerMonth.add((month: month, pushups: pushups));
    });
    pushupsStackedPerMonth.sort((a, b) => a.month.compareTo(b.month));
    return pushupsStackedPerMonth;
  }

  List<({int day, int pushups})> get lastSevenDaysPushups {
    final pushupsStackedPerDay = <({int day, int pushups})>[];
    final dailyPushups = <DateTime, int>{};
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

    for (final pushupSet in this) {
      for (final pushup in pushupSet.pushups) {
        if (pushup.completedAt != null &&
            pushup.completedAt!.isAfter(sevenDaysAgo)) {
          final day = pushup.completedAt?.toLocal().date ?? DateTime.now();
          if (dailyPushups.containsKey(day)) {
            dailyPushups[day] = dailyPushups[day]! + 1;
          } else {
            dailyPushups[day] = 1;
          }
        }
      }
    }

    dailyPushups.forEach((day, pushups) {
      pushupsStackedPerDay.add((day: day.day, pushups: pushups));
    });
    pushupsStackedPerDay.sort((a, b) => a.day.compareTo(b.day));
    return pushupsStackedPerDay;
  }
}
