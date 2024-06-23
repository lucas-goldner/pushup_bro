import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pushup_bro/core/model/game_inventory.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';
import 'package:pushup_bro/core/model/user.dart';
import 'package:pushup_bro/core/provider/db_provder_interface.dart';

class DBProvider implements DBProviderInterface {
  @visibleForTesting
  Isar? db;

  @override
  bool get initialized => Isar.getInstance() != null;

  @override
  Future<void> loadDB() async {
    final dir = await getApplicationSupportDirectory();
    if (initialized) {
      db = Isar.getInstance();
      return;
    }
    db ??= await Isar.open(
      [
        PushupSetSchema,
        UserSchema,
        GameInventorySchema,
      ],
      directory: dir.path,
    );
  }

  @override
  Future<User> getUser() async =>
      await db?.users.get(User.userId) ?? User.empty();

  @override
  Future<User> createUser({int xp = 0, int level = 1}) async {
    final user = User(
      xp: xp,
      level: level,
      name: '',
      image: '',
      friends: [],
      streak: 1,
      longestStreak: 1,
    );
    await db?.writeTxn(() async {
      await db?.users.put(user);
    });

    return user;
  }

  @override
  Future<void> updateUser(User user) async {
    await db?.writeTxn(() async {
      await db?.users.put(user);
    });
  }

  @override
  Future<GameInventory> getInventory() async =>
      await db?.gameInventorys.get(GameInventory.gameInventoryId) ??
      GameInventory.empty();

  @override
  Future<GameInventory> createInventory() async {
    await db?.writeTxn(() async {
      await db?.gameInventorys.put(GameInventory.empty());
    });
    return GameInventory.empty();
  }

  @override
  Future<void> updateInventory(GameInventory inventory) async {
    await db?.writeTxn(() async {
      await db?.gameInventorys.put(inventory);
    });
  }

  @override
  Future<void> addNewPushupSet(PushupSet pushupSet) async {
    await db?.writeTxn(() async {
      await db?.pushupSets.put(pushupSet);
    });
  }

  @override
  Future<void> deletePushupSet(Id id) async {
    await db?.writeTxn(() async {
      await db?.pushupSets.delete(id);
    });
  }

  @override
  Future<List<PushupSet>> getAllPushupSets() async =>
      await db?.pushupSets.where(distinct: true).findAll() ?? [];
}
