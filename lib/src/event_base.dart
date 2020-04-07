// fnando/recurrence

import 'package:jiffy/jiffy.dart';

abstract class EventBase {
  DateTime date;
  DateTime startDate;
  DateTime until;
  bool _finished = false;
  int interval;
  int repeat;
  bool shift;

  EventBase.fromOptions(
    DateTime starts,
    int interval,
    int repeat,
    bool shift,
    DateTime until,
  ) {
    if (interval != null && interval < 1) {
      throw new Exception("interval should be greater than zero");
    }

    if (repeat != null && repeat < 1) {
      throw new Exception("repeat should be greater than zero");
    }

    this.date = starts;
    this.interval = interval != null ? interval : 1;
    this.until = until == null ? Jiffy().add(years: 10) : until;
    this.repeat = repeat;
    this.shift = shift;

    prepare();
  }

  void validate();
  DateTime nextInRecurrence();

  shiftTo(DateTime date) {
    // noop
  }

  void prepare() {
    startDate = next();
    date = null;
  }

  DateTime next() {
    if (_finished) {
      return null;
    }

    if (startDate != null && date == null) {
      date = startDate;
      return _withoutTime(date);
    }

    date = nextInRecurrence();
    if (date.compareTo(until) > 0) {
      _finished = true;
      date = null;
    }

    if (date != null && shift != null && shift) {
      shiftTo(date);
    }

    return _withoutTime(date);
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

  DateTime _withoutTime(DateTime date) {
    return date == null ? null : new DateTime(date.year, date.month, date.day);
  }

}
