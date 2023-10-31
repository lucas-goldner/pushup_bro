import 'package:isar/isar.dart';
import 'package:pushup_bro/core/service/db_service.dart';
import 'package:pushup_bro/features/pushups/model/pushup_set.dart';
import 'package:pushup_bro/features/pushups/repository/pushup_repository.dart';

class PushupRepositoryImpl extends PushupRepository {
  PushupRepositoryImpl(this.dbService);
  final DBService dbService;

  Isar get db => dbService.isar;

  @override
  Future<void> addNewPushupSet(PushupSet pushupSet) async =>
      db.writeTxn(() async {
        await db.pushupSets.put(pushupSet);
      });

  @override
  Future<void> deletePushupSet(int id) async => db.writeTxn(() async {
        await db.pushupSets.delete(id);
      });

  @override
  Future<List<PushupSet>> getAllPushupSets() async =>
      db.pushupSets.where(distinct: true).findAll();
}
