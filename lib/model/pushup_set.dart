import 'package:pushup_bro/model/pushup.dart';

class PushupSet {
  PushupSet(this.pushups);
  final List<Pushup> pushups;

  DateTime get startedDate => pushups.first.completedAt;
  DateTime get completedDate => pushups.last.completedAt;
}
