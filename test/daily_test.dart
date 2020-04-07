import 'package:test/test.dart';
import 'package:in_recurrence/in_recurrence.dart';
import 'package:in_recurrence/src/options.dart';

void main() {
  final now = DateTime.now();

  test('Daily events without until', () {
    var options = new Options(
      frequency: Frequency.daily,
      starts: now
    );
    var recurrences = new InRecurrence(options);
    // until will default to 10 years from now
    expect(recurrences.length, lessThan(3660));
  });

  test('Daily events with until and interval', () {
    Map<int, int> testCases = {
      1: 6,
      2: 3,
      3: 2,
      4: 2,
      5: 2,
      6: 1,
      7: 1
    };

    testCases.forEach((interval, expectedResult) {
      var recurrences = new InRecurrence(new Options(
        frequency: Frequency.daily,
        starts: now,
        interval: interval,
        until: now.add(new Duration(days: 5))
      ));
      expect(recurrences.length, equals(expectedResult));
    });
  });

  test('InRecurrence.includesDate() false when required date is before the event start', () {
    var options = new Options(frequency: Frequency.daily, starts: now);
    var recurrence = new InRecurrence(options);

    expect(
      recurrence.includesDate(
        now.subtract(new Duration(days: 1))
      ),
      equals(false)
    );
  });

  test('InRecurrence.includesDate() false when required date is after the event until', () {
    var options = new Options(
      frequency: Frequency.daily,
      starts: now,
      until: now.add(new Duration(days: 1))
    );
    var recurrence = new InRecurrence(options);

    expect(
      recurrence.includesDate(
        now.add(new Duration(days: 2))
      ),
      equals(false)
    );
  });
}
