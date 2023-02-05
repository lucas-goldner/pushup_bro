import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/flavor/flavor.dart';
import 'package:pushup_bro/model/enum/environment.dart';
import 'package:pushup_bro/ui/view/home.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner:
          Flavor.getCurrentEnvironment == Environment.dev.getFlavorName(),
      key: const Key('MainApp'),
      title: 'Pushup Bro',
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        barBackgroundColor: CupertinoColors.black,
        scaffoldBackgroundColor: CupertinoColors.black,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            backgroundColor: CupertinoColors.black,
          ),
        ),
      ),
      home: const Home(
        title: 'Pushup Bro',
        key: Key('Home'),
      ),
    );
  }
}
