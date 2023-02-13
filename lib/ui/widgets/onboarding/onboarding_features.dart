import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';

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
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Features!',
                style: PBTextStyles.pageTitleTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
