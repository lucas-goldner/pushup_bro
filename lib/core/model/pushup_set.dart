import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/pushup.dart';

part 'pushup_set.g.dart';

@collection
class PushupSet {
  PushupSet(this.pushups, this.effort);
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
      pushups ?? this.pushups,
      effort ?? this.effort,
    );
  }
}
