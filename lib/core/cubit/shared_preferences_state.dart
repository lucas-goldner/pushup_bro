import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SharedPreferencesState extends Equatable {
  const SharedPreferencesState({
    this.language,
    this.volumeLevel,
    this.firstPushupCompleted,
  });
  final Locale? language;
  final int? volumeLevel;
  final bool? firstPushupCompleted;

  @override
  List<Object?> get props => [language, volumeLevel, firstPushupCompleted];
}

class SharedPreferencesInitial extends SharedPreferencesState {
  const SharedPreferencesInitial()
      : super(
          language: const Locale('en'),
          volumeLevel: 10,
          firstPushupCompleted: false,
        );
}

class SharedPreferencesLoaded extends SharedPreferencesState {
  const SharedPreferencesLoaded({
    super.language = const Locale('en'),
    super.volumeLevel = 10,
    super.firstPushupCompleted = false,
  });
}
