import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_cubit.dart';
import 'package:pushup_bro/flavor/flavor.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/model/enum/environment.dart';
import 'package:pushup_bro/provider/airpods_motion_provider.dart';
import 'package:pushup_bro/ui/view/home.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final airpodsMotionProvider = AirPodsMotionProvider();
    final airpodsTrackerCubit = AirPodsTrackerCubit(airpodsMotionProvider);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AirPodsTrackerCubit>(
          create: (context) => airpodsTrackerCubit,
        ),
      ],
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
        home: const Home(
          key: Key('Home'),
        ),
      ),
    );
  }
}
