import 'package:in_recurrence/src/event_base.dart';
import 'options.dart';

class EventWeekly extends EventBase {
  EventWeekly(Options options) : super(options);

  final _onDaysOfWeek = new List<int>();

  @override
  void validate() {
    options.onWeekDays.forEach((day) => {
      if (isValidWeekdayOrWeekdayName(day))
        _onDaysOfWeek.add(day)
    });

    _onDaysOfWeek.sort();
  }

  @override
  DateTime nextInRecurrence() {
    if (!isInitialized() && _onDaysOfWeek.contains(date.weekday)) {
      return date;
    }

    int daysToAdd = 0;
    var nextDay = _onDaysOfWeek.firstWhere(
      (day) => day > date.weekday,
      orElse: () => null
    );

    if (nextDay != null) {
      daysToAdd = nextDay - date.weekday;
    } else {
      daysToAdd = 7 - date.weekday;
      daysToAdd += (interval - 1) * 7;
      daysToAdd += _onDaysOfWeek.first;
    }

    return date.add(new Duration(days: daysToAdd));
  }

  @override
  void shiftTo(DateTime date) {
    // noop
  }
}
