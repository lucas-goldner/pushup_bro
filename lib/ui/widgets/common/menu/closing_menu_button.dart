import 'package:flutter/material.dart';

class ClosingMenuButton extends StatelessWidget {
  const ClosingMenuButton(this.toggle, {required this.open, super.key});
  final VoidCallback toggle;
  final bool open;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 56,
        height: 56,
        child: Center(
          child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: InkWell(
              onTap: toggle,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      );
}
