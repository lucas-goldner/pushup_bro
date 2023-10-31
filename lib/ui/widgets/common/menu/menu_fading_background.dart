import 'package:flutter/material.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';

class MenuFadingBackground extends StatelessWidget {
  const MenuFadingBackground(this.opacity, {super.key});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: opacity == 0.75
            ? PBColors.background2.withOpacity(0.5)
            : Colors.transparent,
      ),
    );
  }
}
