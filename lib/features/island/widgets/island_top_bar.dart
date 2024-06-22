import 'package:flutter/material.dart';
import 'package:pushup_bro/features/island/widgets/banana_counter.dart';

class IslandTopBar extends StatelessWidget {
  const IslandTopBar({super.key});

  @override
  Widget build(BuildContext context) => const SafeArea(
        child: Row(
          children: [
            Spacer(),
            BananaCounter(),
            SizedBox(width: 16),
          ],
        ),
      );
}
