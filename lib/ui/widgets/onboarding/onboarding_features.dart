import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';
import 'package:pushup_bro/ui/widgets/onboarding/onboarding_features_item.dart';

class OnboardingFeatures extends StatelessWidget {
  const OnboardingFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PBColors.onboardingFeaturesBackground,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Features!',
                style: PBTextStyles.pageTitleTextStyle,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: ListView(
                children: const <Widget>[
                  OnboardingFeaturesItem(
                    'Track pushups using Airpods',
                    CarbonIcons.headphones,
                  ),
                  OnboardingFeaturesItem(
                    'Keep track of your sets in the calendar',
                    CarbonIcons.calendar,
                  ),
                  OnboardingFeaturesItem(
                    'Set yourself a daily goal',
                    CarbonIcons.reminder,
                  ),
                  OnboardingFeaturesItem(
                    'Compete with your friends',
                    CarbonIcons.group,
                  ),
                  OnboardingFeaturesItem(
                    'Keep your data synced across devices',
                    CarbonIcons.save,
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'More coming soon..',
                style: PBTextStyles.pageTitleTextStyle,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Text(
                'More ideas? Head to the submit feature section and let me know',
                style: PBTextStyles.defaultTextStyle,
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
