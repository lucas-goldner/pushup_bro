import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';

class OnboardingInitial extends StatelessWidget {
  const OnboardingInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PBColors.onboardingInitialBackground,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'You did it!',
                style: PBTextStyles.pageTitleTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
