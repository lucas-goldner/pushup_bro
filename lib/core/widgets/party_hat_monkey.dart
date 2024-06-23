import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/features/island/model/shop_buyables.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/pushup_cubit.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/pushup_state.dart';
import 'package:pushup_bro/generated/assets.gen.dart';
import 'package:rive/rive.dart';

class PartyHatMonkey extends StatefulWidget {
  const PartyHatMonkey(
    this.equipedAccessory, {
    super.key,
  });

  final ShopBuyables equipedAccessory;

  @override
  State<PartyHatMonkey> createState() => _PartyHatMonkeyState();
}

class _PartyHatMonkeyState extends State<PartyHatMonkey> {
  StateMachineController? _stateMachineController;
  SMIBool? _bump;
  SMIBool? _accessory;
  double height = 250;
  double width = 250;

  void _onInit(Artboard art) {
    final ctrl = StateMachineController.fromArtboard(art, 'PushupState')
      ?..isActive = true;

    if (ctrl != null) {
      _stateMachineController = ctrl;
      art.addController(_stateMachineController!);
      final pushupTrigger =
          _stateMachineController!.findInput<bool>('pushup') as SMIBool?;
      _bump = pushupTrigger;

      final partyHatTrigger =
          _stateMachineController!.findInput<bool>('party_hat') as SMIBool?;
      _accessory = partyHatTrigger;
    }
  }

  @override
  void dispose() {
    _stateMachineController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PartyHatMonkey oldWidget) {
    Future.microtask(_setAccessory);
    super.didUpdateWidget(oldWidget);
  }

  // ignore: use_setters_to_change_properties
  void _triggerPushupAnim(bool anim) => _bump?.value = anim;
  void _setAccessory() => _accessory?.value =
      widget.equipedAccessory == ShopBuyables.accessoryPartyHat;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<PushupCubit, PushupState, bool>(
        selector: (state) => state.inPushup,
        builder: (context, pushupState) {
          _triggerPushupAnim(pushupState);

          return AnimatedContainer(
            duration: const Duration(seconds: 3),
            child: SizedBox(
              height: height,
              width: width,
              child: Assets.rive.partyMonkeyPushup.rive(
                fit: BoxFit.contain,
                onInit: _onInit,
              ),
            ),
          );
        },
      );
}
