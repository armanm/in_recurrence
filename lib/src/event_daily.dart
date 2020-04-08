import 'package:in_recurrence/src/event_base.dart';
import 'options.dart';

class EventDaily extends EventBase {
  EventDaily(Options options) : super(options);

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
