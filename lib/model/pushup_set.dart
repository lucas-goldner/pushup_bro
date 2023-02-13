import 'package:flutter/material.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/model/pushup.dart';

class PushupSet {
  PushupSet(this.pushups, this.effort);
  final List<Pushup> pushups;
  final int effort;

  DateTime get startedDate => pushups.first.completedAt;
  DateTime get completedDate => pushups.last.completedAt;
  int get timeSpent {
    final difference = completedDate.difference(startedDate).inMinutes;
    return difference == 0 ? 1 : difference;
  }

  String translateEffort(BuildContext context) {
    switch (effort) {
      case 0:
        return S.of(context).helloWorld;
      case 1:
        return S.of(context).helloWorld;
      case 2:
        return S.of(context).helloWorld;
      case 3:
        return S.of(context).helloWorld;
      case 4:
        return S.of(context).helloWorld;
      case 5:
        return S.of(context).helloWorld;
    }

    return '';
  }
}
