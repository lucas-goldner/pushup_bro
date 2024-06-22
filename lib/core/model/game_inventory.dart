import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:pushup_bro/features/island/model/shop_buyables.dart';

part 'game_inventory.g.dart';

const Id _gameInventoryId = 1;

@collection
class GameInventory extends Equatable {
  const GameInventory({
    required this.bananas,
    required this.boughtItems,
    this.id = _gameInventoryId,
  });

  factory GameInventory.empty() => const GameInventory(
        bananas: 0,
        boughtItems: [],
      );

  final Id id;
  final int bananas;
  @Enumerated(EnumType.name)
  final List<ShopBuyables> boughtItems;
  static Id get gameInventoryId => _gameInventoryId;

  GameInventory copyWith({int? bananas, List<ShopBuyables>? boughtItems}) =>
      GameInventory(
        bananas: bananas ?? this.bananas,
        boughtItems: boughtItems ?? this.boughtItems,
      );

  @override
  List<Object?> get props => [bananas, boughtItems, id];
}
