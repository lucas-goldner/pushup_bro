import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/widgets/onboarding/onboarding_create_account.dart';
import 'package:pushup_bro/ui/widgets/onboarding/onboarding_login.dart';

class OnboardingAccount extends StatefulWidget {
  const OnboardingAccount({super.key});

  @override
  State<OnboardingAccount> createState() => _OnboardingAccountState();
}

class _OnboardingAccountState extends State<OnboardingAccount> {
  final CarouselController _carouselController = CarouselController();

  void navigateToPage(int pageViewIndex) =>
      _carouselController.animateToPage(pageViewIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PBColors.onboardingLoginBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: 2,
            itemBuilder: (context, itemIndex, pageViewIndex) => itemIndex == 0
                ? OnboardingCreateAccount(() => navigateToPage(1))
                : OnboardingLogin(() => navigateToPage(0)),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 1.5,
              enlargeCenterPage: true,
              enlargeFactor: 1,
              scrollPhysics: const NeverScrollableScrollPhysics(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Divider(
              height: 1,
              thickness: 2,
              color: CupertinoColors.white,
            ),
          )
        ],
      ),
    );
  }
}
