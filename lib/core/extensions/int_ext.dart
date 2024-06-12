extension IntExtension on int {
  List<DateTime> get lastSevenDays {
    final now = DateTime.now();
    final days = <DateTime>[];
    for (var i = 0; i < 7; i++) {
      days.add(now.subtract(Duration(days: this + i)));
    }
    return days;
  }
}
