import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pushup_bro/cubit/shared_preferences/shared_preferences_cubit.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});
  static const routeName = '/calendar';

  Future<String> getLanguage(BuildContext context) async =>
      BlocProvider.of<SharedPreferencesCubit>(context).getLanguage();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 64),
            FutureBuilder(
              future: getLanguage(context),
              builder: (context, language) => TableCalendar<Widget>(
                locale: language.data ?? 'en',
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(
                  DateTime.now().year,
                  DateTime.now().month + 1,
                  DateTime.now().day,
                ),
                focusedDay: DateTime.now(),
                daysOfWeekHeight: 32,
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                ),
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, day) {
                    return Center(
                      child: Text(
                        DateFormat.yMMMM().format(day),
                        style: PBTextStyles.headerTextStyle,
                      ),
                    );
                  },
                  dowBuilder: (context, day) {
                    return Center(
                      child: Text(
                        DateFormat.E().format(day),
                        style: PBTextStyles.headerTextStyle,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
