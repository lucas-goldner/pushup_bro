import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:pushup_bro/generated/assets.gen.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';
import 'package:rive/rive.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    required this.text, super.key,
    this.icon,
    this.callback,
  });
  final String text;
  final IconData? icon;
  final VoidCallback? callback;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  OneShotAnimation? _btnController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _btnController = OneShotAnimation('active', autoplay: false);

    const springDesc = SpringDescription(
      mass: 0.1,
      stiffness: 40,
      damping: 5,
    );

    if (_btnController == null) return;
    final isButtonControllerActive = _btnController?.isActive ?? false;

    _btnController?.isActiveChanged.addListener(() {
      if (!isButtonControllerActive) {
        final springAnim = SpringSimulation(springDesc, 0, 1, 0);
        _controller?.animateWith(springAnim);
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _btnController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          _btnController?.isActive = true;
          widget.callback?.call();
        },
        child: Stack(
          children: [
            Assets.rive.button.rive(
              fit: BoxFit.cover,
              controllers: <OneShotAnimation>[
                if (_btnController != null)
                  _btnController ?? OneShotAnimation(''),
              ],
            ),
            Center(
              child: Transform.translate(
                offset: const Offset(4, 4),
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
                      style: PBTextStyles.buttonTextStyle,
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
