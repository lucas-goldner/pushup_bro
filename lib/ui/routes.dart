import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/model/navigation_parameter.dart';
import 'package:pushup_bro/model/pushup_set.dart';
import 'package:pushup_bro/ui/view/calendar.dart';
import 'package:pushup_bro/ui/view/home.dart';
import 'package:pushup_bro/ui/view/onboarding.dart';
import 'package:pushup_bro/ui/view/settings.dart';
import 'package:pushup_bro/ui/widgets/common/page_container.dart';

class RouteGenerator {
  Route<CupertinoPageRoute<Widget>>? onGenerateMainRoutes(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case Home.routeName:
        final params = settings.arguments as NavigationParameter?;
        return _revealCircular(
          params?.context,
          PageContainer(const Home(), title: params?.title),
        );
      case Calendar.routeName:
        final params = settings.arguments as NavigationParameter?;
        return _revealCircular(
          params?.context,
          PageContainer(
            const Calendar(),
            title: params?.title,
          ),
        );
      case Settings.routeName:
        final params = settings.arguments as NavigationParameter?;
        return _revealCircular(
          params?.context,
          PageContainer(
            const Settings(),
            title: params?.title,
          ),
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

  Route<CupertinoPageRoute<Widget>>? _revealCircular(
    BuildContext? context,
    Widget widget,
  ) {
    if (context == null) {
      return CupertinoPageRoute(
        builder: (context) => widget,
      );
    }
    return CircularClipRoute(
      expandFrom: context,
      builder: (_) => widget,
    );
  }
}
