import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/fake_pushups_state.dart';

class FakePushupCubit extends Cubit<FakePushupsState> {
  FakePushupCubit() : super(const FakePushupsState(fakePushupsOn: false));

  void toggleFakePushups() {
    emit(FakePushupsState(fakePushupsOn: !state.fakePushupsOn));
  }
}
