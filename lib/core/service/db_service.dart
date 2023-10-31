import 'package:isar/isar.dart';

abstract class DBService {
  Future<void> loadDB();
  Isar get isar;
}
