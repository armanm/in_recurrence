import 'package:in_recurrence/src/event_base.dart';
import 'package:in_recurrence/src/options.dart';
import 'package:jiffy/jiffy.dart';
import 'dart:math';

class EventMonthly extends EventBase {
  EventMonthly(Options options) : super(options);
  int _on;

  @override
  void validate() {
    if (options.weekday != null) {
      if (options.ordinal == Ordinal.last) {
        _on = 5;
      }  else if (options.ordinal == null) {
        throw new Exception('Missing a weekday option or ordinal for monthly event');
      } else {
        _on = options.ordinal.index + 1;
      }
    } else {
      isValidMonthDay(options.onMonthDay);
      _on = options.onMonthDay;
    }
  }

  @override
  void shiftTo(DateTime date) {
    _on = date.weekday;
  }

  @override
  DateTime nextInRecurrence() {
    if (options.weekday != null) {
      if (isInitialized()) return advanceToMonthByWeekday(date);
      DateTime newDate = advanceToMonthByWeekday(date, 0);
      return date.isAfter(newDate) ? advanceToMonthByWeekday(date) : newDate;
    } else {
      if (isInitialized()) return advanceToMonthByMonthday(date);
      DateTime newDate = advanceToMonthByMonthday(date, 0);
      return date.isAfter(newDate) ? advanceToMonthByMonthday(date) : newDate;
    }
  }

  DateTime advanceToMonthByMonthday(DateTime date, [int aInterval]) {
    aInterval = aInterval == null ? this.interval : aInterval;

    int rawMonth = date.month + aInterval - 1;
    int nextYear = (date.year + rawMonth / 12).floor();
    int nextMonth = (rawMonth % 12) + 1;

    return new DateTime.utc(
      nextYear,
      nextMonth,
      min(_on, Jiffy(DateTime.utc(nextYear, nextMonth)).daysInMonth)
    );
  }

  DateTime advanceToMonthByWeekday(DateTime date, [int aInterval]) {
    aInterval = aInterval == null ? this.interval : aInterval;

    int rawMonth  = date.month + aInterval - 1;
    int nextYear = (date.year + rawMonth / 12).floor();
    int nextMonth = (rawMonth % 12) + 1;

    date = DateTime.utc(nextYear, nextMonth, 1);
    int month = date.month;

    // Adjust week day
    int toAdd = options.weekday.index - date.weekday;

    toAdd += toAdd < 0 ? 7 : 0;
    toAdd += (_on - 1) * 7;
    date = date.add(Duration(days: toAdd));

    // Go to the previous month if we lost it
    if (date.month != month) {
      int weeks = ((date.day - 1) / 7).floor() + 1;
      date = date.subtract(Duration(days: weeks * 7));
    }

    return new DateTime.utc(
      date.year,
      date.month,
      min(date.day, Jiffy(DateTime.utc(date.year, date.month)).daysInMonth)
    );
  }

  bool isValidWeek(int week) {
    if (week >= 1 && week <= 5) return true;
    throw new Exception('Invalid week $week');
  }
}
