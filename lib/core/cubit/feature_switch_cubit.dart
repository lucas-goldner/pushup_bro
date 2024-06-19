import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/feature_switch_state.dart';

class FeatureSwitchCubit extends Cubit<FeatureSwitchState> {
  FeatureSwitchCubit() : super(const FeatureSwitchStateHookmodel());

  void switchFeature(FeatureSwitchState featureSwitchState) =>
      emit(featureSwitchState);
}
