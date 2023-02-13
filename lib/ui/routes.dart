import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/model/pushup_set.dart';
import 'package:pushup_bro/ui/view/home.dart';
import 'package:pushup_bro/ui/view/onboarding.dart';

class RouteGenerator {
  Route<CupertinoPageRoute<Widget>>? onGenerateMainRoutes(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case Home.routeName:
        return CupertinoPageRoute(
          builder: (context) => const Home(),
        );
      case Onboarding.routeName:
        final pushupsSet = settings.arguments as PushupSet?;
        if (pushupsSet == null) return null;
        return CupertinoPageRoute(
          builder: (context) => Onboarding(pushupsSet.pushups.length),
        );
    }

    return null;
  }
}
