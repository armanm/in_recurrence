import 'package:in_recurrence/src/options.dart';
import 'package:test/test.dart';

void main() {
  test('InRecurrenceOptions.isValid() retrurns true when frequency is set', () {
    final options = new Options(
      frequency: Frequency.daily
    );
    expect(options.isValid(), equals(true));
  });

  test('InRecurrenceOptions.isValid() retrurns false when frequency is set', () {
    final options = new Options();
    expect(options.isValid(), equals(false));
  });
}
