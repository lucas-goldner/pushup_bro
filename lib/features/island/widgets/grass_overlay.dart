import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

class GrassOverlay extends StatefulWidget {
  const GrassOverlay({super.key});

  @override
  State<GrassOverlay> createState() => _GrassOverlayState();
}

class _GrassOverlayState extends State<GrassOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 200, end: 210).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const newDay = true;

    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: context.sizeOf.width / 4,
            child: Assets.images.island.jungle.image(
              width: 200,
            ),
          ),
          Positioned(
            top: 10,
            left: -10,
            child: Assets.images.island.palm.image(
              width: 200,
            ),
          ),
          if (newDay)
            AnimatedBuilder(
              animation: _animation,
              builder: (animation, _) => Transform(
                transform: Matrix4.translationValues(
                  context.sizeOf.width / 2.2,
                  _animation.value,
                  0,
                ),
                child: Transform.scale(
                  scaleX: 2,
                  child: const Icon(
                    CarbonIcons.arrow_up,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          Positioned(
            top: -20,
            left: context.sizeOf.width / 2,
            child: Assets.images.island.palm.image(
              width: 200,
            ),
          ),
          Positioned(
            top: 100,
            left: context.sizeOf.width / 2,
            child: Transform.scale(
              scale: 0.4,
              child: Assets.images.island.bush1.image(
                width: 200,
              ),
            ),
          ),
          Positioned(
            top: 115,
            left: context.sizeOf.width / 1.5,
            child: Assets.images.island.palm.image(
              width: 200,
            ),
          ),
          Positioned(
            top: 10,
            right: context.sizeOf.width / 2,
            child: Assets.images.island.palm.image(
              width: 200,
            ),
          ),
          Positioned(
            top: 270,
            left: 50,
            child: Assets.images.island.bush2.image(
              width: 100,
            ),
          ),
          Positioned(
            top: 150,
            left: 0,
            child: Assets.images.island.bush1.image(
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
