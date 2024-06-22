import 'package:equatable/equatable.dart';
import 'package:pushup_bro/core/model/game_inventory.dart';

sealed class GameInventoryState extends Equatable {
  const GameInventoryState(this.inventory);

  final GameInventory inventory;

  @override
  List<Object?> get props => [inventory];
}

class GameInventoryStateInitial extends GameInventoryState {
  const GameInventoryStateInitial()
      : super(const GameInventory(bananas: 0, boughtItems: []));
}

class GameInventoryFetching extends GameInventoryState {
  const GameInventoryFetching()
      : super(const GameInventory(bananas: 0, boughtItems: []));
}

class GameInventoryLoaded extends GameInventoryState {
  const GameInventoryLoaded(super.inventory);
}
