import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

class Island extends StatefulWidget {
  const Island({super.key});
  static const routeName = '/island';

  @override
  State<Island> createState() => _IslandState();
}

class _IslandState extends State<Island> {
  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 64),
              Text(
                'General App Debug',
                style: context.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      );
}
