import 'package:equatable/equatable.dart';

class FakePushupsState extends Equatable {
  const FakePushupsState({required this.fakePushupsOn});
  final bool fakePushupsOn;

  @override
  List<Object> get props => [fakePushupsOn];
}
