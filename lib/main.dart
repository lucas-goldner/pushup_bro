import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl_standalone.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_cubit.dart';
import 'package:pushup_bro/cubit/pushups/pushup_cubit.dart';
import 'package:pushup_bro/cubit/shared_preferences/shared_preferences_cubit.dart';
import 'package:pushup_bro/cubit/shared_preferences/shared_preferences_state.dart';
import 'package:pushup_bro/flavor/flavor.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/model/enum/environment.dart';
import 'package:pushup_bro/model/enum/shared_preferences_key.dart';
import 'package:pushup_bro/provider/airpods_motion_provider.dart';
import 'package:pushup_bro/provider/audio_player_provider.dart';
import 'package:pushup_bro/provider/shared_preferences_provider.dart';
import 'package:pushup_bro/ui/routes.dart';
import 'package:pushup_bro/utils/constants.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  void setAudioContext() {
    const audioContext = AudioContext(
      iOS: AudioContextIOS(
        options: [
          AVAudioSessionOptions.mixWithOthers,
        ],
      ),
    );
    AudioPlayer.global.setGlobalAudioContext(audioContext);
    AudioPlayer.global.changeLogLevel(LogLevel.none);
  }

  Future<void> initializeSharedPreferences(
    SharedPreferencesProvider sharedPreferencesProvider,
    SharedPreferencesCubit sharedPreferencesCubit,
  ) async {
    final selectedLanguage = await sharedPreferencesProvider
        .getSharedPrefString(SharedPreferencesKey.language);

    await sharedPreferencesCubit.setLanguage(
      selectedLanguage != null
          ? Locale(selectedLanguage)
          : Locale(await findSystemLocale()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Providers
    final audioPlayer = AudioPlayer(playerId: Constants.audioPlayerId);
    final audioPlayerProvider = AudioPlayerProvider(audioPlayer);
    final airpodsMotionProvider = AirPodsMotionProvider();
    final sharedPreferencesProvider = SharedPreferencesProvider()
      ..loadSharedPrefs();

    // Cubits
    final airpodsTrackerCubit = AirPodsTrackerCubit(airpodsMotionProvider);
    final pushupCubit = PushupCubit(audioPlayerProvider);
    final sharedPreferencesCubit =
        SharedPreferencesCubit(sharedPreferencesProvider);

    // Configuration
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    setAudioContext();
    initializeSharedPreferences(
      sharedPreferencesProvider,
      sharedPreferencesCubit,
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
      ],
      child:
          BlocSelector<SharedPreferencesCubit, SharedPreferencesState, Locale?>(
        selector: (state) => state.language,
        builder: (builder, locale) {
          return CupertinoApp(
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
            theme: const CupertinoThemeData(
              brightness: Brightness.dark,
              barBackgroundColor: CupertinoColors.black,
              scaffoldBackgroundColor: CupertinoColors.black,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  color: CupertinoColors.black,
                ),
              ),
            ),
            onGenerateRoute: (settings) =>
                RouteGenerator().onGenerateMainRoutes(settings),
          );
        },
      ),
    );
  }
}
