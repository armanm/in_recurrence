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
  DateTime through;
  int repeat;
  bool shift;

  Options({
    this.except,
    this.frequency,
    this.starts,
    this.until,
    this.through,
    this.repeat,
    this.shift
  });

  isValid() => this.frequency == null ? false : true;
}
