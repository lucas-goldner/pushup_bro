import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

class Ground extends StatelessWidget {
  const Ground({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Flexible(
            child: ColoredBox(
              color: context.gameColorsTheme.grass,
              child: const SizedBox.expand(),
            ),
          ),
          Flexible(
            flex: 2,
            child: ColoredBox(
              color: context.gameColorsTheme.sand,
              child: const SizedBox.expand(),
            ),
          ),
        ],
      );
}
