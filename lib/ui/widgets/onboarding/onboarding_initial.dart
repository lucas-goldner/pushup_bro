import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/model/pushup_set.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';
import 'package:pushup_bro/ui/widgets/home/monkey.dart';

class OnboardingInitial extends StatelessWidget {
  const OnboardingInitial(this.pushupSet, {super.key});
  final PushupSet pushupSet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PBColors.onboardingInitialBackground,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'You did it!',
                style: PBTextStyles.pageTitleTextStyle.copyWith(
                  color: CupertinoColors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Center(child: Monkey()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Well done! You completed your first set of ${pushupSet.pushups.length} pushups with Carlos the Gorilla. It seems like it was pretty ${pushupSet.translateEffort(context)}.\n\nKeep working towards building a higher and consistent pushup count.',
                style: PBTextStyles.headerTextStyle.copyWith(
                  color: CupertinoColors.white,
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
