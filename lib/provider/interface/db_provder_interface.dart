import 'package:pushup_bro/model/pushup_set.dart';

abstract class DBProviderInterface {
  bool get initialized;
  Future<void> loadDB();
  Future<void> addNewPushupSet(PushupSet pushupSet);
  Future<void> deletePushupSet(int id);
}
