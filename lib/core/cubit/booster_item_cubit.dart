import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/booster_item_state.dart';
import 'package:pushup_bro/core/model/booster_items.dart';

class BoosterItemCubit extends Cubit<BoosterItemState> {
  BoosterItemCubit() : super(BoosterItemStateInitial());

  void addItems({required BoosterItems item, required int amount}) {
    final currentState = state;
    if (currentState is! BoosterItemStateLoaded) {
      return;
    }
    final itemsAmount = currentState.items[item];
    if (itemsAmount == null) {
      return;
    }
    final newItemsAmount = itemsAmount + amount;

    emit(
      BoosterItemStateLoaded({
        ...currentState.items,
        item: newItemsAmount,
      }),
    );
  }

  void consumeItem({required BoosterItems item}) {
    final currentState = state;
    if (currentState is! BoosterItemStateLoaded) {
      return;
    }
    final itemsAmount = currentState.items[item];
    if (itemsAmount == null) {
      return;
    }
    final newItemsAmount = itemsAmount - 1;

    emit(
      BoosterItemStateLoaded({
        ...currentState.items,
        item: newItemsAmount,
      }),
    );
  }
}
