import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

class AirpodsConnectionText extends StatefulWidget {
  const AirpodsConnectionText({super.key});

  @override
  State<AirpodsConnectionText> createState() => _AirpodsConnectionTextState();
}

class _AirpodsConnectionTextState extends State<AirpodsConnectionText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = '${context.l10n.lookingForAirpods}...';

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimatedItem(
              Assets.images.airpodsLeft.image(width: 64, height: 64),
              0,
            ),
            const SizedBox(width: 8),
            ..._buildAnimatedText(text, 1),
            const SizedBox(width: 8),
            _buildAnimatedItem(
              Assets.images.airpodsRight.image(width: 64, height: 64),
              text.length + 1,
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildAnimatedText(String text, int startIndex) {
    final animatedText = <Widget>[];
    for (var i = 0; i < text.length; i++) {
      animatedText.add(
        _buildAnimatedItem(
          Text(
            text[i],
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          startIndex + i,
        ),
      );
    }
    return animatedText;
  }

  Widget _buildAnimatedItem(Widget child, int index) {
    return Transform.translate(
      offset: Offset(
        0,
        math.sin((_animation.value * 2 * math.pi) + (index * 0.5)) * 8,
      ),
      child: child,
    );
  }
}
