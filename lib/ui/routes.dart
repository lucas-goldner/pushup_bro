import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/ui/view/home.dart';

class RouteGenerator {
  Route<CupertinoPageRoute<Widget>>? onGenerateMainRoutes(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case Home.routeName:
        return _homePageRoute();
    }

    return null;
  }

  Route<CupertinoPageRoute<Widget>>? _homePageRoute() {
    return CupertinoPageRoute(
      builder: (context) => const Home(),
    );
  }
}
