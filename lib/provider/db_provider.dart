import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:pushup_bro/model/pushup_set.dart';
import 'package:pushup_bro/provider/interface/db_provder_interface.dart';

class DBProvider implements DBProviderInterface {
  @visibleForTesting
  Isar? db;

  @override
  bool get initialized => db != null;

  @override
  Future<void> loadDB() async {
    db ??= await Isar.open([PushupSetSchema]);
  }

  @override
  Future<void> addNewPushupSet(PushupSet pushupSet) async {
    await db?.writeTxn(() async {
      await db?.pushupSets.put(pushupSet);
    });
  }

  @override
  Future<void> deletePushupSet(int id) async {
    await db?.writeTxn(() async {
      await db?.pushupSets.delete(id);
    });
  }
}
