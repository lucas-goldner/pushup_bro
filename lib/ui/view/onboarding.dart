import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pushup_bro/model/pushup_set.dart';
import 'package:pushup_bro/ui/widgets/onboarding/onboarding_features.dart';
import 'package:pushup_bro/ui/widgets/onboarding/onboarding_initial.dart';
import 'package:pushup_bro/ui/widgets/onboarding/onboarding_login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding(this.pushupSet, {super.key});
  final PushupSet pushupSet;
  static const routeName = 'onboarding';

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  LiquidController? liquidController;
  int currentPage = 0;
  Color iconColor = CupertinoColors.black;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  void handlePageChange(int page) => page == 0
      ? setState(
          () => {currentPage = page, iconColor = CupertinoColors.black},
        )
      : setState(
          () => {currentPage = page, iconColor = CupertinoColors.white},
        );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: LiquidSwipe(
        slideIconWidget: Icon(
          CarbonIcons.arrow_right,
          color: iconColor,
        ),
        fullTransitionValue: 880,
        enableSideReveal: true,
        ignoreUserGestureWhileAnimating: true,
        liquidController: liquidController,
        onPageChangeCallback: handlePageChange,
        pages: [
          OnboardingInitial(widget.pushupSet),
          const OnboardingFeatures(),
          const OnboardingLogin()
        ],
      ),
    );
  }
}
