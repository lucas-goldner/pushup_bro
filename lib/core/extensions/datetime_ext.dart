extension DateOnlyCompare on DateTime {
  DateTime get date => DateTime(year, month, day);
  List<DateTime> get lastSevenDays =>
      List.generate(7, (index) => subtract(Duration(days: index)).date)
          .reversed
          .toList();
  int get lastDayOfCurrentMonth => DateTime(year, month, 0).day;
}
