import 'package:pushup_bro/features/pushups/model/pushup_set.dart';

abstract class PushupRepository {
  Future<List<PushupSet>> getAllPushupSets();
  Future<void> addNewPushupSet(PushupSet pushupSet);
  Future<void> deletePushupSet(int id);
}
