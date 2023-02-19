import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';

class InfoItem extends StatelessWidget {
  const InfoItem(this.name, this.icon, this.openInfo, {super.key});
  final String name;
  final IconData icon;
  final VoidCallback openInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openInfo,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: PBColors.background2,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Icon(icon),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  name,
                  style: PBTextStyles.buttonTextStyle
                      .copyWith(color: CupertinoColors.white),
                ),
                const Spacer(),
                const Icon(CarbonIcons.link, color: CupertinoColors.white),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
