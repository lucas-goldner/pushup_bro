import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';

class OnboardingLogin extends StatelessWidget {
  const OnboardingLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PBColors.onboardingLoginBackground,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Create account',
                style: PBTextStyles.pageTitleTextStyle.copyWith(
                  color: CupertinoColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
