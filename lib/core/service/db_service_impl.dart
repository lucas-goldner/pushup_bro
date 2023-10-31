import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pushup_bro/core/service/db_service.dart';
import 'package:pushup_bro/features/pushups/model/pushup_set.dart';

class DBServiceImpl implements DBService {
  DBServiceImpl._(this._isar);
  late final Isar _isar;

  Future<DBServiceImpl> create(Isar? isar) async =>
      DBServiceImpl._(isar ?? await loadDB());

  @override
  Future<Isar> loadDB() async {
    final dir = await getApplicationSupportDirectory();
    return Isar.open([PushupSetSchema], directory: dir.path);
  }

  @override
  Isar get isar => _isar;
}
