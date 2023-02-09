import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_state.dart';
import 'package:pushup_bro/provider/airpods_motion_provider.dart';

class AirPodsTrackerCubit extends Cubit<AirPodsTrackerState> {
  AirPodsTrackerCubit(this._airPodsMotionProvider)
      : super(
          const AirPodsTrackerStateInitial(),
        );

  final AirPodsMotionProvider _airPodsMotionProvider;

  void getAirPodsMotionData() {
    _airPodsMotionProvider.airPodsMotionService.getMotionData().listen((event) {
      emit(AirPodsTrackerStateListening(event));
    });
  }
}
