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

typedef MonthlyPushups = ({int month, int pushups});
typedef DailyPushups = ({int day, int pushups});

extension PushupSetListExtension on List<PushupSet> {
  List<MonthlyPushups> get stackedPerMonth {
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

  MonthlyPushups get monthWithMostPushups {
    final pushupsByMonth = stackedPerMonth;
    return pushupsByMonth.reduce(
      (max, element) => element.pushups > max.pushups ? element : max,
    );
  }

  List<DailyPushups> get lastSevenDaysPushups {
    final dailyPushups = <DateTime, int>{};
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    for (final pushupSet in this) {
      for (final pushup in pushupSet.pushups) {
        if (pushup.completedAt != null &&
            pushup.completedAt!.isAfter(sevenDaysAgo)) {
          final day = pushup.completedAt!.date;
          dailyPushups[day] = (dailyPushups[day] ?? 0) + 1;
        }
      }
    }

    return List.generate(7, (index) {
      final targetDay = now.subtract(Duration(days: index)).date;
      return (day: targetDay.day, pushups: dailyPushups[targetDay] ?? 0);
    }).reversed.toList();
  }
}
