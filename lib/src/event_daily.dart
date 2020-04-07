import 'package:in_recurrence/src/event_base.dart';
import 'dart:math';

class EventDaily extends EventBase {
  DateTime nextInRecurrence() {
    return isInitialized()
      ? date.add(new Duration(days: interval))
      : date;
  }
}
