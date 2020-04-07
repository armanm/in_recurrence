enum Frequency {
  daily,
  weekly,
  monthly,
  yearly
}

class Options {
  Frequency frequency;
  List<DateTime> except;
  DateTime starts;
  DateTime until;
  int repeat;
  bool shift;
  int interval;

  Options({
    this.except,
    this.frequency,
    this.starts,
    this.until,
    this.repeat,
    this.shift,
    this.interval
  });

  isValid() => this.frequency == null ? false : true;
}
