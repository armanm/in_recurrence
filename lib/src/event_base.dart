// fnando/recurrence

import 'package:jiffy/jiffy.dart';
import 'options.dart';

abstract class EventBase {
  Options options;

  DateTime date;
  DateTime startDate;
  DateTime until;
  int interval;

  bool _finished = false;

  EventBase(Options options) {
    this.options = options;

    validate();

    if (options.interval != null && options.interval < 1) {
      throw new Exception("interval should be greater than zero");
    }

    if (options.repeat != null && options.repeat < 1) {
      throw new Exception("repeat should be greater than zero");
    }

    this.date = DateTime.utc(options.starts.year, options.starts.month, options.starts.day);
    this.interval = options.interval != null ? options.interval : 1;
    this.until = options.until == null ? Jiffy().add(years: 10) : options.until;

    prepare();
  }

  void validate();
  DateTime nextInRecurrence();

  void shiftTo(DateTime date);

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
      return date;
    }

    date = nextInRecurrence();
    if (date.compareTo(until) > 0) {
      _finished = true;
      date = null;
    }

    if (date != null && options.shift != null && options.shift) {
      shiftTo(date);
    }

    return date;
  }

  bool isInitialized() {
    return startDate != null;
  }

  bool isValidMonthDay(int day) {
    if (day >= 1 || day <= 31) return true;
    throw new Exception("invalid day of the month $day");
  }

  bool isValidWeekdayOrWeekdayName(int day){
    if (day > 0 && day <= 7) return true;
    throw new Exception("invalid day of the week $day");
  }
}
