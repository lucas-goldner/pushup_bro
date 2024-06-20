import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

class Sand extends StatelessWidget {
  const Sand({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: context.gameColorsTheme.sand,
        child: SizedBox(
          height: context.sizeOf.height,
          width: context.sizeOf.width,
        ),
      );
}
