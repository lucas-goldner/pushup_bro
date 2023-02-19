import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:pushup_bro/cubit/shared_preferences/shared_preferences_state.dart';
import 'package:pushup_bro/model/enum/shared_preferences_key.dart';
import 'package:pushup_bro/provider/interface/shared_preferences_interface.dart';

class SharedPreferencesCubit extends Cubit<SharedPreferencesState> {
  SharedPreferencesCubit(this._sharedPreferencesProvider)
      : super(const SharedPreferencesInitial());
  final SharedPreferencesInterface _sharedPreferencesProvider;

  Future<String> getLanguage() async {
    final selectedLanguage =
        await _sharedPreferencesProvider.getSharedPrefString(
      SharedPreferencesKey.language,
    );

    final systemLanguage = await findSystemLocale();

    return selectedLanguage ?? systemLanguage;
  }

  Future<bool> getFirstPushupCompleted() async {
    final firstPushupCompleted =
        await _sharedPreferencesProvider.getSharedPrefBool(
      SharedPreferencesKey.firstPushupDone,
    );

    return firstPushupCompleted ?? false;
  }

  Future<void> setLanguage(Locale locale) async {
    await _sharedPreferencesProvider.writeStringToSharedPrefs(
      SharedPreferencesKey.language,
      locale.toLanguageTag(),
    );
  }

  Future<void> setVolume(double volume) async {
    await _sharedPreferencesProvider.writeIntToSharedPrefs(
      SharedPreferencesKey.volume,
      value: (volume * 10) as int,
    );
  }

  Future<void> setFirstPushupCompleted({required bool completed}) async {
    await _sharedPreferencesProvider.writeBoolToSharedPrefs(
      SharedPreferencesKey.firstPushupDone,
      value: completed,
    );
  }

  Future<void> setFirstJoined() async {
    if (await getFirstJoined() == null) {
      await _sharedPreferencesProvider.writeStringToSharedPrefs(
        SharedPreferencesKey.joined,
        DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      );
    }
  }

  Future<DateTime?> getFirstJoined() async {
    final dateString = await _sharedPreferencesProvider.getSharedPrefString(
          SharedPreferencesKey.joined,
        ) ??
        '';
    if (dateString != '') {
      return DateFormat('yyyy-MM-dd hh:mm:ss').parse(
        dateString,
      );
    }
    return null;
  }
}
