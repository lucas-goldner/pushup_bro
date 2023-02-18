import 'dart:math' as math;
import 'package:flutter/cupertino.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({
    super.key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.nthChild,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final int nthChild;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final offset = Offset.fromDirection(
      directionInDegrees * (math.pi / 180.0),
      progress.value * maxDistance,
    );

    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) => Positioned(
        bottom: 4.0 - offset.dy * nthChild - maxDistance,
        child: Transform.rotate(
          angle: (1.0 - progress.value) * math.pi / 2,
          child: child,
        ),
      ),
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
