import 'package:equatable/equatable.dart';
import 'package:pushup_bro/model/pushup_set.dart';

class DBState extends Equatable {
  const DBState(this.pushupSets);
  final List<PushupSet> pushupSets;

  @override
  List<Object?> get props => [pushupSets];
}

class DBStateInitial extends DBState {
  DBStateInitial() : super([]);
}

class DBStateLoaded extends DBState {
  const DBStateLoaded(super.pushupSets);
}
