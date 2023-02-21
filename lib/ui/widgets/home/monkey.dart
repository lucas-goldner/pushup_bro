import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/pushups/pushup_cubit.dart';
import 'package:pushup_bro/cubit/pushups/pushup_state.dart';
import 'package:pushup_bro/generated/assets.gen.dart';
import 'package:rive/rive.dart';

class Monkey extends StatefulWidget {
  const Monkey({super.key});

  @override
  State<Monkey> createState() => _MonkeyState();
}

class _MonkeyState extends State<Monkey> {
  SMIBool? _bump;
  double height = 250;
  double width = 250;

  void _onInit(Artboard art) {
    final ctrl = StateMachineController.fromArtboard(art, 'PushupState')
      ?..isActive = false;

    if (ctrl != null) {
      art.addController(ctrl);
      final pushupTrigger = ctrl.findInput<bool>('pushup') as SMIBool?;
      _bump = pushupTrigger;
    }
  }

  // ignore: use_setters_to_change_properties
  void _triggerPushupAnim(bool anim) => _bump?.value = anim;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PushupCubit, PushupState, bool>(
      selector: (state) => state.inPushup,
      builder: (context, pushupState) {
        _triggerPushupAnim(pushupState);

        return AnimatedContainer(
          duration: const Duration(seconds: 3),
          child: SizedBox(
            height: height,
            width: width,
            child: Assets.rive.monkeyPushup.rive(
              fit: BoxFit.contain,
              onInit: _onInit,
            ),
          ),
        );
      },
    );
  }
}
