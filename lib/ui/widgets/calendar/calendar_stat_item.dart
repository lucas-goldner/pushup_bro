import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';

class CalendarStatItem extends StatelessWidget {
  const CalendarStatItem(this.text, this.icon, {super.key});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PBColors.accentColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: PBTextStyles.defaultTextStyle.copyWith(
            color: CupertinoColors.white,
          ),
        ),
      ],
    );
  }
}
