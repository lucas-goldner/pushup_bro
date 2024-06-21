import 'package:flutter/material.dart';
import 'package:pushup_bro/core/widgets/monkey.dart';
import 'package:pushup_bro/features/island/model/turning_direction.dart';

class WalkingMonkey extends StatefulWidget {
  const WalkingMonkey({super.key});

  @override
  State<WalkingMonkey> createState() => _WalkingMonkeyState();
}

class _WalkingMonkeyState extends State<WalkingMonkey>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final animationPath = Tween<double>(begin: 20, end: 200);
  TurningDirection turningDirection = TurningDirection.right;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: animationPath.begin, end: animationPath.end)
            .animate(_controller)
          ..addListener(() {
            if (_animation.value >= (animationPath.end! - 0.2)) {
              setState(() => turningDirection = TurningDirection.left);
            }

            if (_animation.value <= (animationPath.begin! + 0.2)) {
              setState(() => turningDirection = TurningDirection.right);
            }
          });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Positioned(
          left: _animation.value,
          top: MediaQuery.of(context).size.height / 3,
          child: Transform.scale(
            scale: 0.5,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(
                turningDirection == TurningDirection.right ? 3.1416 : 0.0,
              ),
              child: const Monkey(),
            ),
          ),
        ),
      );
}
