import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/pushups/pushup_cubit.dart';
import 'package:pushup_bro/cubit/pushups/pushup_state.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

class Monkey extends StatefulWidget {
  const Monkey({super.key});

  @override
  State<Monkey> createState() => _MonkeyState();
}

class _MonkeyState extends State<Monkey> {
  double height = 250;
  double width = 250;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PushupCubit, PushupState, bool>(
      selector: (state) => state.inPushup,
      builder: (context, pushupState) => AnimatedContainer(
        duration: const Duration(seconds: 3),
        child: SizedBox(
          height: height,
          width: width,
          child: Assets.rive.carlosIdle.rive(fit: BoxFit.contain),
        ),
      ),
    );
  }
}
