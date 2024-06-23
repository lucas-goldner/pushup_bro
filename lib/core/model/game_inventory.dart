import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:pushup_bro/features/island/model/adoptable_monkey.dart';
import 'package:pushup_bro/features/island/model/shop_buyables.dart';

part 'game_inventory.g.dart';

const Id _gameInventoryId = 1;

@Collection(inheritance: false)
class GameInventory extends Equatable {
  const GameInventory({
    required this.bananas,
    required this.boughtItems,
    required this.monkeys,
    this.id = _gameInventoryId,
  });

  factory GameInventory.empty() => GameInventory(
        bananas: 0,
        boughtItems: const [],
        monkeys: [AdoptableMonkey.carlos()],
      );

  final Id id;
  final int bananas;
  @Enumerated(EnumType.name)
  final List<ShopBuyables> boughtItems;
  final List<AdoptableMonkey> monkeys;
  static Id get gameInventoryId => _gameInventoryId;

  GameInventory copyWith({
    int? bananas,
    List<ShopBuyables>? boughtItems,
    List<AdoptableMonkey>? monkeys,
  }) =>
      GameInventory(
        bananas: bananas ?? this.bananas,
        boughtItems: boughtItems ?? this.boughtItems,
        monkeys: monkeys ?? this.monkeys,
      );

  @override
  @ignore
  List<Object?> get props => [bananas, boughtItems, id, monkeys];
}
