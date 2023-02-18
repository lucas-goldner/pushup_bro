import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pushup_bro/cubit/db/db_cubit.dart';
import 'package:pushup_bro/cubit/db/db_state.dart';
import 'package:pushup_bro/cubit/shared_preferences/shared_preferences_cubit.dart';
import 'package:pushup_bro/model/pushup_set.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';
import 'package:pushup_bro/ui/widgets/calendar/calendar_event.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});
  static const routeName = '/calendar';

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();

  Future<String> getLanguage(BuildContext context) async =>
      BlocProvider.of<SharedPreferencesCubit>(context).getLanguage();

  List<PushupSet> _getEventsForDay(
    List<PushupSet> pushupSets,
    DateTime day,
  ) {
    // debugPrint(day.toString());
    // debugPrint(pushupSets.toString());

    return pushupSets
        .where((pset) => isSameDay(pset.completedDate, day))
        .toList();
  }

  void updateSelectedDate(DateTime day) => setState(() => _selectedDay = day);

  @override
  void initState() {
    BlocProvider.of<DBCubit>(context).getAllPushupSets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: BlocBuilder<DBCubit, DBState>(
          builder: (context, state) {
            // debugPrint(state.pushupSets.length.toString());
            final eventsPerDay =
                _getEventsForDay(state.pushupSets, _selectedDay);
            return Column(
              children: [
                const SizedBox(height: 64),
                FutureBuilder(
                  future: getLanguage(context),
                  builder: (context, language) => TableCalendar<PushupSet>(
                    locale: language.data ?? 'en',
                    firstDay: DateTime.utc(2010, 10, 16),
                    eventLoader: (day) =>
                        _getEventsForDay(state.pushupSets, day),
                    lastDay: DateTime.utc(
                      DateTime.now().year,
                      DateTime.now().month + 1,
                      DateTime.now().day,
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) =>
                        updateSelectedDate(selectedDay),
                    focusedDay: DateTime.now(),
                    daysOfWeekHeight: 32,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      leftChevronIcon: Icon(
                        CarbonIcons.chevron_left,
                        color: PBColors.accentColor,
                      ),
                      rightChevronIcon: Icon(
                        CarbonIcons.chevron_right,
                        color: PBColors.accentColor,
                      ),
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) {
                        if (events.isNotEmpty) {
                          return Center(
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(40),
                                ),
                                border: Border.all(
                                  width: 2,
                                  color: CupertinoColors.activeGreen,
                                ),
                              ),
                            ),
                          );
                        }
                        return null;
                      },
                      selectedBuilder: (context, day, focusedDay) => Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(40),
                            ),
                            border: Border.all(
                              width: 2,
                              color: PBColors.accentColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              DateFormat.d().format(day),
                              style: PBTextStyles.defaultTextStyle,
                            ),
                          ),
                        ),
                      ),
                      todayBuilder: (context, day, focusedDay) => DecoratedBox(
                        decoration: const BoxDecoration(
                          color: PBColors.background2,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Text(
                            DateFormat.d().format(day),
                            style: PBTextStyles.headerTextStyle
                                .copyWith(color: CupertinoColors.white),
                          ),
                        ),
                      ),
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
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i <= eventsPerDay.length - 1; i++) ...{
                          CalendarEvent(eventsPerDay[i]),
                        }
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
}
