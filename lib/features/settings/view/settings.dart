import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/core/model/website_links.dart';
import 'package:pushup_bro/core/provider/url_launch_provider.dart';
import 'package:pushup_bro/core/style/pb_text_styles.dart';
import 'package:pushup_bro/features/settings/view/settings_language.dart';
import 'package:pushup_bro/features/settings/view/settings_volume.dart';
import 'package:pushup_bro/features/settings/widgets/info_item.dart';
import 'package:pushup_bro/features/settings/widgets/settings_item.dart';
import 'package:pushup_bro/generated/l10n.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static const routeName = '/settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _launchProvider = UrlLauncherProvider(const UrlLauncherService());

  void openBrowser(Uri uri) => _launchProvider.launchUri(uri);

  Uri createURI(String path) => Uri(scheme: 'https', path: path);

  void navigateToSettingPage(String routeName) =>
      Navigator.of(context).pushNamed(routeName);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                S.of(context).general,
                style: headerTextStyle,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Settingsitem(
              S.of(context).switchLanguage,
              CarbonIcons.language,
              () => navigateToSettingPage(LanguageSetting.routeName),
            ),
            const SizedBox(
              height: 8,
            ),
            Settingsitem(
              S.of(context).setVolume,
              CarbonIcons.volume_up,
              () => navigateToSettingPage(VolumeSetting.routeName),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                S.of(context).info,
                style: headerTextStyle,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            InfoItem(
              S.of(context).website,
              CarbonIcons.explore,
              () => openBrowser(createURI(WebsiteLinks.personalSite.link)),
            ),
            const SizedBox(
              height: 8,
            ),
            InfoItem(
              S.of(context).twitter,
              CarbonIcons.logo_twitter,
              () => openBrowser(createURI(WebsiteLinks.twitter.link)),
            ),
            const SizedBox(
              height: 8,
            ),
            InfoItem(
              S.of(context).privacyPolicy,
              CarbonIcons.virtual_private_cloud,
              () => openBrowser(createURI(WebsiteLinks.privacyPolicy.link)),
            ),
            const SizedBox(
              height: 8,
            ),
            InfoItem(
              S.of(context).termsOfService,
              CarbonIcons.term,
              () => openBrowser(createURI(WebsiteLinks.termsOfService.link)),
            ),
            const SizedBox(
              height: 8,
            ),
            // TODO(License): Create license page
            // InfoItem(
            //   'Credits',
            //   CarbonIcons.credentials,
            //   () => openBrowser(createURI('lucas-goldner.com')),
            // ),
          ],
        ),
      );
}
