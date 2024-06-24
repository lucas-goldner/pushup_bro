import 'package:equatable/equatable.dart';

class DayState extends Equatable {
  const DayState(this.day);
  final int day;

  DayState copyWith({int? day}) => DayState(day ?? this.day);

  @override
  List<Object?> get props => [day];
}
