import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/model/pushup_set.dart';
import 'package:pushup_bro/ui/view/home.dart';
import 'package:pushup_bro/ui/view/onboarding.dart';
import 'package:pushup_bro/ui/widgets/common/page_container.dart';

class RouteGenerator {
  Route<CupertinoPageRoute<Widget>>? onGenerateMainRoutes(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case Home.routeName:
        return CupertinoPageRoute(
          builder: (context) => const PageContainer(Home()),
        );
      case Onboarding.routeName:
        final pushupsSet = settings.arguments as PushupSet?;
        if (pushupsSet == null) return null;
        return CupertinoPageRoute(
          builder: (context) => Onboarding(pushupsSet),
        );
    }

    return null;
  }
}
