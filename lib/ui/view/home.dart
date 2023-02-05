import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/widgets/home/home_app_bar.dart';
import 'package:rive/rive.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: PBColors.bgColor,
      child: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
            Text(
              S.of(context).helloWorld,
              style: const TextStyle(
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 200,
              width: 200,
              child: RiveAnimation.asset(
                'assets/rive/carlos_idle.riv',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
