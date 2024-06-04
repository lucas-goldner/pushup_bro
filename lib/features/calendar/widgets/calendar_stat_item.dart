import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/style/pb_colors.dart';
import 'package:pushup_bro/core/style/pb_text_styles.dart';

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
          color: accentColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: defaultTextStyle.copyWith(
            color: CupertinoColors.white,
          ),
        ),
      ],
    );
  }
}
