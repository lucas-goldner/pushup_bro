import 'package:isar/isar.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';

abstract class DBProviderInterface {
  bool get initialized;
  Future<void> loadDB();
  Future<List<PushupSet>> getAllPushupSets();
  Future<void> addNewPushupSet(PushupSet pushupSet);
  Future<void> deletePushupSet(Id id);
}
