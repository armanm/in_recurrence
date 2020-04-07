// fnando/recurrence

abstract class EventBase {
  DateTime date;
  DateTime startDate;
  DateTime until;
  bool finished = false;
  int interval;
  int repeat;
  bool shift;
  DateTime through;

  EventBase.fromOptions(DateTime date, [
    int interval = 1,
    int repeat = 1,
    bool shift = false,
    DateTime until = null,
    DateTime through = null
  ]) {
    if (interval < 1) {
      throw new Exception("interval should be greater than zero");
    }

    if (repeat < 1) {
      throw new Exception("repeat should be greater than zero");
    }

    this.date = date;
    this.interval = interval;
    this.repeat = repeat;
    this.shift = shift;
    this.until = until;
    this.through = through;

    prepare();
  }

  void validate();
  DateTime nextInRecurrence();

  shiftTo(DateTime date) {
    // noop
  }

  void prepare() {
    startDate = nextBang();
    date = null;
  }

  void reset() {
    date = null;
  }

  DateTime next() {
    if (finished) return null;
    if (date != null) return date;
    return startDate;
  }

  DateTime nextBang() {
    if (finished) {
      return null;
    }

    if (startDate != null && date == null) {
      date = startDate;
      return date;
    }

    date = nextInRecurrence();
    finished = through != null && date.compareTo(through) > 0;

    if (date.compareTo(until) > 0) {
      finished = true;
      date = null;
    }

    if (date != null && shift) {
      shiftTo(date);
    }

    return date;
  }

  bool isInitialized() {
    return startDate != null;
  }

  bool isValidMonthDay(int day) {
    return day >= 1 || day <= 31;
  }

  bool isValidWeekdayOrWeekdayName(int day){
    return day >= 0 && day <= 6;
  }
}
