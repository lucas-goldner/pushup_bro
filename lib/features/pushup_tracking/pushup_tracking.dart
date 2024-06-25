import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pushup_bro/core/cubit/fake_pushups_cubit.dart';
import 'package:pushup_bro/core/cubit/feature_switch_cubit.dart';
import 'package:pushup_bro/core/cubit/feature_switch_state.dart';
import 'package:pushup_bro/core/cubit/game_inventory_cubit.dart';
import 'package:pushup_bro/core/cubit/game_inventory_state.dart';
import 'package:pushup_bro/core/cubit/shared_preferences_cubit.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';
import 'package:pushup_bro/core/widgets/monkey.dart';
import 'package:pushup_bro/core/widgets/party_hat_monkey.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/features/island/model/adoptable_monkey.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/airpods_tracker_cubit.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/airpods_tracker_state.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/pushup_cubit.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/pushup_state.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/airpods_connection_modal.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/finished_pushup_sheet/finished_set_bottom_sheet.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/news_banner/news_banner.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/pushup_counter.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/pushup_tracking_bottom_row.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/pushup_tracking_top_row.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

class PushupTracking extends StatefulWidget {
  const PushupTracking({super.key});
  static const String routeName = '/';

  @override
  State<PushupTracking> createState() => _PushupTrackingState();
}

class _PushupTrackingState extends State<PushupTracking> {
  bool finished = false;
  bool started = false;
  bool newsVisible = true;
  bool searchingForAirPods = false;

  void toggleListeningUpdates() {
    final airpodsCubit = BlocProvider.of<AirPodsTrackerCubit>(context);
    final pushupCubit = BlocProvider.of<PushupCubit>(context);

    if (started && pushupCubit.getCurrentPushups() >= 1) {
      airpodsCubit.stopListening();
      final pushups = pushupCubit.resetAndReturnCurrentPushupSet();
      setState(() {
        finished = true;
        searchingForAirPods = false;
        started = false;
      });
      openBottomSheet(pushups);
    } else {
      airpodsCubit.getAirPodsMotionData();
      if (newsVisible == true) {
        setState(() => newsVisible = false);
      }
      setState(() {
        finished = false;
        started = true;
        searchingForAirPods = true;
      });
    }
  }

  Future<void> openBottomSheet(PushupSet pushups) async {
    // final navigator = Navigator.of(context);
    // final firstPushupCompleted =
    await showCupertinoModalBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      enableDrag: false,
      isDismissible: false,
      builder: (context) => FinishedSetBottomSheet(pushups),
    );

    // ?? false;
    // TODO(ImplementOnboarding): Reenable onboarding and finish feature
    // if (!firstPushupCompleted) {
    //   await navigator.pushNamed(
    //     Onboarding.routeName,
    //     arguments: PushupSet([], 0),
    //   );
    // }
  }

  void toggleNewsVisibility() => setState(() => newsVisible = !newsVisible);
  void closeAirPodsModal() => setState(() => searchingForAirPods = false);

  @override
  void initState() {
    super.initState();
    newsVisible = false;
    // TODO(RealApp): fetch news and items
    // context.read<NewsCubit>().getNews(context.read<DayCubit>().state.day);
    // context.read<BoosterItemCubit>().fetchItems(
    //       context.read<DayCubit>().state.day,
    //     );
  }

  @override
  void didUpdateWidget(covariant PushupTracking oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: BlocProvider.of<SharedPreferencesCubit>(context).getVolume(),
        builder: (context, future) => Stack(
          children: [
            SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      PushupTrackingTopRow(
                        toggleNewsVisibility: toggleNewsVisibility,
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                      BlocBuilder<FeatureSwitchCubit, FeatureSwitchState>(
                        builder: (context, state) {
                          if (state is FeatureSwitchStateGamification) {
                            return BlocSelector<GameInventoryCubit,
                                GameInventoryState, AdoptableMonkey>(
                              selector: (state) =>
                                  state.inventory.monkeys.first,
                              builder: (context, monkey) =>
                                  PartyHatMonkey(monkey.accessory),
                            );
                          }

                          return const Monkey();
                        },
                      ),
                      BlocConsumer<AirPodsTrackerCubit, AirPodsTrackerState>(
                        listener: (context, state) {
                          if (state.isListening && started) {
                            setState(() => searchingForAirPods = false);
                          }
                        },
                        builder: (context, airPodsState) {
                          if (airPodsState.isListening && started) {
                            final pushupCubit =
                                BlocProvider.of<PushupCubit>(context)
                                  ..listenForPushupEvents(
                                    airPodsState.currentMotionData,
                                    future.data ?? 10,
                                  );

                            if (context
                                .read<FakePushupCubit>()
                                .state
                                .fakePushupsOn) {
                              return Column(
                                children: [
                                  BlocSelector<PushupCubit, PushupState, int>(
                                    selector: (state) => state.pushups.length,
                                    builder: (context, count) => PushupCounter(
                                      count,
                                    ),
                                  ),
                                  PBButton(
                                    'Add pushup',
                                    onTap: () {
                                      BlocProvider.of<PushupCubit>(context)
                                          .addFakePushup();
                                    },
                                  ),
                                ],
                              );
                            }

                            return PushupCounter(
                              pushupCubit.getCurrentPushups(),
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                      const Spacer(flex: 2),
                      PushupTrackingBottomRow(
                        toggleListeningUpdates: toggleListeningUpdates,
                        started: started,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            NewsBanner(newsVisible: newsVisible),
            if (finished)
              IgnorePointer(
                child: Assets.rive.confetti.rive(),
              ),
            if (searchingForAirPods)
              AirPodsConnectionModal(
                closeAirPodsModal: closeAirPodsModal,
              ),
          ],
        ),
      );
}
