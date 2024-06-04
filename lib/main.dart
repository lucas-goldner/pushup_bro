import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:pushup_bro/core/constants.dart';
import 'package:pushup_bro/core/cubit/db_cubit.dart';
import 'package:pushup_bro/core/cubit/shared_preferences_cubit.dart';
import 'package:pushup_bro/core/cubit/shared_preferences_state.dart';
import 'package:pushup_bro/core/extensions/string_ext.dart';
import 'package:pushup_bro/core/flavor.dart';
import 'package:pushup_bro/core/model/environment.dart';
import 'package:pushup_bro/core/model/shared_preferences_key.dart';
import 'package:pushup_bro/core/provider/audio_player_provider.dart';
import 'package:pushup_bro/core/provider/shared_preferences_provider.dart';
import 'package:pushup_bro/core/style/theme.dart';
import 'package:pushup_bro/features/menu/model/routes.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/airpods_tracker_cubit.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/pushup_cubit.dart';
import 'package:pushup_bro/features/pushup_tracking/provider/airpods_motion_provider.dart';
import 'package:pushup_bro/features/pushup_tracking/provider/db_provider.dart';
import 'package:pushup_bro/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO(Firebase): Enable firebase when implemented
  // await Firebase.initializeApp();
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  // );
  await initializeDateFormatting().then((_) => runApp(const Main()));
}

class Main extends StatelessWidget {
  const Main({super.key});

  void setAudioContext() {
    final audioContext = AudioContext(
      iOS: AudioContextIOS(
        options: const {
          AVAudioSessionOptions.mixWithOthers,
        },
      ),
    );
    AudioPlayer.global.setAudioContext(audioContext);
  }

  Future<void> initializeSharedPreferences(
    SharedPreferencesProvider sharedPreferencesProvider,
    SharedPreferencesCubit sharedPreferencesCubit,
  ) async {
    final selectedLanguage = await sharedPreferencesProvider
        .getSharedPrefString(SharedPreferencesKey.language);

    final systemLocale = await findSystemLocale();
    await sharedPreferencesCubit.setLanguage(
      selectedLanguage != null
          ? Locale(selectedLanguage)
          : Locale(systemLocale.getLanguageCode()),
    );

    await sharedPreferencesCubit.setFirstJoined();
  }

  void _initConfig(
    SharedPreferencesProvider sharedPreferencesProvider,
    SharedPreferencesCubit sharedPreferencesCubit,
    DBProvider dbProvider,
  ) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.light,
      ),
    );
    setAudioContext();
    initializeSharedPreferences(
      sharedPreferencesProvider,
      sharedPreferencesCubit,
    );
    sharedPreferencesCubit.getLanguage();
    if (!dbProvider.initialized) dbProvider.loadDB();
  }

  @override
  Widget build(BuildContext context) {
    // Providers
    final audioPlayer = AudioPlayer(playerId: audioPlayerId);
    final audioPlayerProvider = AudioPlayerProvider(audioPlayer);
    final airpodsMotionProvider = AirPodsMotionProvider();
    final sharedPreferencesProvider = SharedPreferencesProvider()
      ..loadSharedPrefs();
    final dbProvider = DBProvider();

    // Cubits
    final airpodsTrackerCubit = AirPodsTrackerCubit(airpodsMotionProvider);
    final pushupCubit = PushupCubit(audioPlayerProvider);
    final sharedPreferencesCubit =
        SharedPreferencesCubit(sharedPreferencesProvider);
    final dbCubit = DBCubit(dbProvider);

    // Configuration
    _initConfig(
      sharedPreferencesProvider,
      sharedPreferencesCubit,
      dbProvider,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<AirPodsTrackerCubit>(
          create: (context) => airpodsTrackerCubit,
        ),
        BlocProvider<PushupCubit>(
          create: (context) => pushupCubit,
        ),
        BlocProvider<SharedPreferencesCubit>(
          create: (context) => sharedPreferencesCubit,
        ),
        BlocProvider<DBCubit>(
          create: (context) => dbCubit,
        ),
      ],
      child:
          BlocSelector<SharedPreferencesCubit, SharedPreferencesState, Locale?>(
        selector: (state) => state.language,
        builder: (builder, locale) => Theme(
          data: theme,
          child: CupertinoApp(
            debugShowCheckedModeBanner:
                Flavor.getCurrentEnvironment == Environment.dev.getFlavorName(),
            key: const Key('MainApp'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: generateRoutes,
          ),
        ),
      ),
    );
  }
}
