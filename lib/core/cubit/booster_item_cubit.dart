import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/booster_item_state.dart';
import 'package:pushup_bro/core/model/booster_items.dart';
import 'package:pushup_bro/core/provider/data_for_day.dart';

class BoosterItemCubit extends Cubit<BoosterItemState> {
  BoosterItemCubit() : super(BoosterItemStateInitial());

  void fetchItems(int day) {
    final itemsPerDay = getItemsForDay(day);
    for (final item in itemsPerDay) {
      addItems(item: item, amount: 1);
    }
  }

  void resetItems() {
    emit(
      const BoosterItemStateLoaded({
        BoosterItems.doublePoints: 0,
        BoosterItems.friendBoost: 0,
      }),
    );
  }

  void addItems({required BoosterItems item, required int amount}) {
    final itemsAmount = state.items[item];
    if (itemsAmount == null) {
      return;
    }
    final newItemsAmount = itemsAmount + amount;

    emit(
      BoosterItemStateLoaded({
        ...state.items,
        item: newItemsAmount,
      }),
    );
  }

  void consumeItem({required BoosterItems item}) {
    final itemsAmount = state.items[item];
    if (itemsAmount == null || itemsAmount == 0) {
      return;
    }
    final newItemsAmount = itemsAmount - 1;

    emit(
      BoosterItemStateLoaded({
        ...state.items,
        item: newItemsAmount,
      }),
    );
  }
}
