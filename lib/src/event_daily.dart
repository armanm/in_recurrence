import 'package:in_recurrence/src/event_base.dart';

class EventDaily extends EventBase {
  EventDaily.fromOptions(
    DateTime date,
    int interval,
    int repeat,
    bool shift,
    DateTime until,
  ) : super.fromOptions(date, interval, repeat, shift, until);

  @override
  void validate() {
    // noop
  }

  DateTime nextInRecurrence() {
    return isInitialized()
      ? date.add(new Duration(days: interval))
      : date;
  }
}
