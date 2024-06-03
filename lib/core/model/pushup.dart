import 'package:isar/isar.dart';

part 'pushup.g.dart';

@embedded
class Pushup {
  Pushup({this.completedAt});
  DateTime? completedAt;
}
