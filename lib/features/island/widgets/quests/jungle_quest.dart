import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/day_cubit.dart';
import 'package:pushup_bro/core/provider/data_for_day.dart';

class JungleQuest extends StatelessWidget {
  const JungleQuest({
    super.key,
  });

  @override
  Widget build(BuildContext context) => getJungleQuestOfDay(
        context.read<DayCubit>().state.day,
      );
}
