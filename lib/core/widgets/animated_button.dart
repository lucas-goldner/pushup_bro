import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:pushup_bro/core/style/theme.dart';
import 'package:pushup_bro/generated/assets.gen.dart';
import 'package:rive/rive.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    required this.text,
    super.key,
    this.icon,
    this.callback,
    this.isPressed,
  });
  final String text;
  final IconData? icon;
  final VoidCallback? callback;
  final bool? isPressed;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _riveController;
  late AnimationController _arrowAnimController;
  late Animation<Offset> _arrowAnimation;
  late OneShotAnimation? _riveAnim;

  @override
  void initState() {
    super.initState();
    _riveController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _arrowAnimController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _riveAnim = OneShotAnimation('active', autoplay: false);

    const springDesc = SpringDescription(
      mass: 0.1,
      stiffness: 40,
      damping: 5,
    );

    _arrowAnimation = Tween<Offset>(
      begin: const Offset(-4, 0),
      end: const Offset(4, 0),
    ).animate(
      CurvedAnimation(
        parent: _arrowAnimController,
        curve: Curves.easeInOut,
      ),
    );

    if (_riveAnim == null) return;
    final isButtonControllerActive = _riveAnim?.isActive ?? false;

    _riveAnim?.isActiveChanged.addListener(() {
      if (!isButtonControllerActive) {
        final springAnim = SpringSimulation(springDesc, 0, 1, 0);
        _riveController.animateWith(springAnim);
      }
    });
  }

  @override
  void dispose() {
    _riveController.dispose();
    _riveAnim?.dispose();
    super.dispose();
  }

  void _onTap() {
    _riveAnim?.isActive = true;
    widget.callback?.call();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 240,
        height: 64,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(1, 10),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: _onTap,
            child: Stack(
              children: [
                Assets.rive.button.rive(
                  fit: BoxFit.cover,
                  controllers: <OneShotAnimation>[
                    if (_riveAnim != null) _riveAnim ?? OneShotAnimation(''),
                  ],
                ),
                Center(
                  child: AnimatedBuilder(
                    animation: _arrowAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: (widget.isPressed ?? false)
                            ? Offset.zero
                            : _arrowAnimation.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: widget.icon != null,
                              child: Icon(widget.icon),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: theme.colorScheme.primary,
                                  ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
