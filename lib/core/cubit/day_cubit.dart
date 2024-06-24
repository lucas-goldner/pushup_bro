import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/day_state.dart';

class DayCubit extends Cubit<DayState> {
  DayCubit() : super(const DayState(1));

  void increment() {
    if (state.day != 3) {
      emit(state.copyWith(day: state.day + 1));
    }
  }

  void reset() => emit(state.copyWith(day: 1));
}
