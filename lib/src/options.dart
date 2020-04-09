enum Frequency {
  daily,
  weekly,
  monthly,
  yearly
}

enum Ordinal {
  first,
  second,
  third,
  fourth,
  fifth,
  last
}

enum Weekday {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday
}

class Options {
  Frequency frequency;
  List<DateTime> except;
  DateTime starts;
  DateTime until;
  int repeat;
  bool shift;
  int interval;
  List<int> onWeekDays;
  int onMonthDay;
  Ordinal ordinal;
  Weekday weekday;

  Options({
    this.except,
    this.frequency,
    this.starts,
    this.until,
    this.repeat,
    this.shift,
    this.interval,
    this.onWeekDays,
    this.onMonthDay,
    this.ordinal,
    this.weekday
  });

  isValid() => this.frequency == null ? false : true;
}
