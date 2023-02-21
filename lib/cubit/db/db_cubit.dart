import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/db/db_state.dart';
import 'package:pushup_bro/model/pushup_set.dart';
import 'package:pushup_bro/provider/db_provider.dart';

class DBCubit extends Cubit<DBState> {
  DBCubit(this._dbProvider) : super(DBStateInitial());
  final DBProvider _dbProvider;

  Future<void> writeNewPushupsetToDB(PushupSet pushupSet) async {
    await _dbProvider.addNewPushupSet(pushupSet);
    await getAllPushupSets();
  }

  Future<void> deletePushupSetFromDB(int id) async {
    await _dbProvider.deletePushupSet(id);
    await getAllPushupSets();
  }

  Future<List<PushupSet>> getAllPushupSets() async {
    final pushupsets = await _dbProvider.getAllPushupSets();
    emit(DBStateLoaded(pushupsets));
    return pushupsets;
  }
}
