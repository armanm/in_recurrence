import 'dart:collection';
import 'package:in_recurrence/src/event_base.dart';
import 'package:in_recurrence/src/event_daily.dart';
import 'package:in_recurrence/src/event_monthly.dart';
import 'package:in_recurrence/src/event_weekly.dart';
import 'package:in_recurrence/src/options.dart';

class InRecurrence with IterableMixin<DateTime> {
  Options options;

  InRecurrence(this.options);

  bool includesDate(DateTime requiredDate) {
    if (requiredDate.compareTo(options.starts) < 0) return false;
    if (options.until != null && requiredDate.compareTo(options.until) > 0) return false;

    return true;
  }

  @override
  Iterator<DateTime> get iterator => events().iterator;

  Iterable<DateTime> events() sync* {
    var event = _initializeEvent();
    DateTime nextOccurence;

    while((nextOccurence = event.next()) != null) {
      yield nextOccurence;
    }
  }

  EventBase _initializeEvent() {
    switch (options.frequency) {
      case Frequency.daily: return new EventDaily(options);
      case Frequency.weekly: return new EventWeekly(options);
      case Frequency.monthly: return new EventMonthly(options);
      default: throw new Exception('${options.frequency} is not supported');
    }
  }
}
