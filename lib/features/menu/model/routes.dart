import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/features/menu/model/menu_tab_info.dart';
import 'package:pushup_bro/features/menu/widgets/page_container.dart';
import 'package:pushup_bro/features/progress/view/progress.dart';
import 'package:pushup_bro/features/pushup_tracking/view/pushup_tracking.dart';
import 'package:pushup_bro/features/settings/view/settings.dart';
import 'package:pushup_bro/features/settings/view/settings_language.dart';
import 'package:pushup_bro/features/settings/view/settings_volume.dart';

Route<CupertinoPageRoute<Widget>> generateRoutes(
  RouteSettings settings,
) =>
    switch (settings.name) {
      PushupTracking.routeName => _revealCircular(
          settings.arguments as BuildContext?,
          const PageContainer(
            PushupTracking(),
            menuTab: MenuTabInfo.pushupTracking,
          ),
        ),
      Progress.routeName => _revealCircular(
          settings.arguments as BuildContext?,
          const PageContainer(
            Progress(),
            menuTab: MenuTabInfo.progress,
          ),
        ),
      Settings.routeName => _revealCircular(
          settings.arguments as BuildContext?,
          const PageContainer(
            Settings(),
            menuTab: MenuTabInfo.settings,
          ),
        ),
      LanguageSetting.routeName => CupertinoPageRoute(
          builder: (context) => const LanguageSetting(),
        ),
      VolumeSetting.routeName => CupertinoPageRoute(
          builder: (context) => const VolumeSetting(),
        ),
      _ => _revealCircular(
          settings.arguments as BuildContext?,
          const PageContainer(
            PushupTracking(),
            menuTab: MenuTabInfo.pushupTracking,
          ),
        ),
    };

Route<CupertinoPageRoute<Widget>> _revealCircular(
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
