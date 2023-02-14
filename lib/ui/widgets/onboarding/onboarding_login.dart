import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';
import 'package:pushup_bro/ui/widgets/common/pb_button.dart';
import 'package:pushup_bro/ui/widgets/common/pb_text_input.dart';

class OnboardingLogin extends StatefulWidget {
  const OnboardingLogin(this.navigateToPage, {super.key});
  final VoidCallback navigateToPage;

  @override
  State<OnboardingLogin> createState() => _OnboardingLoginState();
}

class _OnboardingLoginState extends State<OnboardingLogin> {
  @override
  Widget build(BuildContext context) {
    final pageTitleTextStyle =
        PBTextStyles.pageTitleTextStyle.copyWith(color: CupertinoColors.white);
    final secondaryPageTextStyle =
        PBTextStyles.secondaryPageTitleTextStyle.copyWith(
      color: CupertinoColors.white,
    );
    final headerTextStyle =
        PBTextStyles.headerTextStyle.copyWith(color: CupertinoColors.white);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  S.of(context).login,
                  style: pageTitleTextStyle,
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: widget.navigateToPage,
                  child: Text(
                    S.of(context).orCreateAccount,
                    style: secondaryPageTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              S.of(context).email,
              style: headerTextStyle,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: PBTextInput(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              S.of(context).password,
              style: headerTextStyle,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: PBTextInput(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              child: PBButton(S.of(context).login),
            ),
          ),
        ],
      ),
    );
  }
}
