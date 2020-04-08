import 'package:test/test.dart';
import 'package:in_recurrence/in_recurrence.dart';
import 'package:in_recurrence/src/options.dart';

void main() {
  final now = DateTime.now();

  test('Weekly events without until', () {
    var options = new Options(
      frequency: Frequency.weekly,
      starts: new DateTime(2020, 4, 8),
      until: now.add(Duration(days: 14)),
      onDays: [3, 4]
    );
    var recurrences = new InRecurrence(options);
    // until will default to 10 years from now
    recurrences.forEach((events) => print(events.toIso8601String()));
    // expect(recurrences.length, lessThan(3660));
  });
}
