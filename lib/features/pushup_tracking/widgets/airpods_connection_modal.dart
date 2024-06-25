import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/airpods_connection_text.dart';

class AirPodsConnectionModal extends StatefulWidget {
  const AirPodsConnectionModal({required this.closeAirPodsModal, super.key});
  final VoidCallback closeAirPodsModal;

  @override
  State<AirPodsConnectionModal> createState() => _AirPodsConnectionModalState();
}

class _AirPodsConnectionModalState extends State<AirPodsConnectionModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO(PermissionCheck): Implement permission check for AirPods tracking
    // const permissionGranted = true;

    return Stack(
      children: [
        Positioned.fill(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ColoredBox(
              color: context.colorScheme.surfaceDim.withOpacity(0.8),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height / 2.2,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(48),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: widget.closeAirPodsModal,
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const AirpodsConnectionText(),
                  const Spacer(),
                  // if (permissionGranted)
                  Text(
                    'Note: AirPods tracking does not work while on a call.',
                    style: context.textTheme.bodyMedium,
                  ),
                  // else
                  //   Column(
                  //     children: [
                  //       const Text(
                  //       'You need to grant permission to track your AirPods',
                  //       ),
                  //       PBButton('Request Permission', onTap: () {}),
                  //     ],
                  //   ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
