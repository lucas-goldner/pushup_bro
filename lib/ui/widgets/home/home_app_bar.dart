import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        CupertinoButton(
          onPressed: null,
          child: Icon(
            CarbonIcons.menu,
            color: PBColors.primaryColor,
            size: 28,
          ),
        ),
        Spacer(),
        Text(
          'Pushup Bro',
          style: PBTextStyles.boldTextStyle,
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
