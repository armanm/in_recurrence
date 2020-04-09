import 'package:jiffy/jiffy.dart';
import 'package:test/test.dart';
import 'package:in_recurrence/in_recurrence.dart';
import 'package:in_recurrence/src/options.dart';

void main() {
  final now = DateTime.now();

  test('Monthly events without until', () {
    var options = new Options(
      frequency: Frequency.monthly,
      starts: new DateTime(2020, 4, 8),
      until: Jiffy(now).add(years: 1),
      onMonthDay: 14
    );
    var recurrences = new InRecurrence(options);
    recurrences.forEach((events) => print(events.toIso8601String()));
  });

  test('Monthly events without dates that fall on the boundary', () {
    final now = new DateTime(2015, 4, 8);

    var options = new Options(
      frequency: Frequency.monthly,
      starts: now,
      until: Jiffy(now).add(years: 1),
      onMonthDay: 31
    );
    var recurrences = new InRecurrence(options);
    recurrences.forEach((events) => print(events.toIso8601String()));
  });

  test('Monthly events with ordinals', () {
    var options = new Options(
      frequency: Frequency.monthly,
      starts: new DateTime(2020, 4, 8),
      until: Jiffy(now).add(years: 1),
      weekday: Weekday.tuesday,
      ordinal: Ordinal.second
    );
    var recurrences = new InRecurrence(options);
    recurrences.forEach((events) => print(events.toIso8601String()));
  });
}
