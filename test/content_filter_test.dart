import 'package:flutter_test/flutter_test.dart';
import 'package:glucocircle/core/safety/content_filter.dart';

void main() {
  group('holds for review', () {
    for (final text in [
      'Stop your insulin! This powder works.',
      'You should skip the medicine tonight',
      'insulin chhor do',
      'dawai band kar do',
      'This herbal powder cured my diabetes',
      'DM me to order',
      'Message me on WhatsApp',
      'Call 0300 1234567',
      'Visit www.example.com',
      'see example.pk for more',
    ]) {
      test(text, () => expect(ContentFilter.shouldHold(text), isTrue));
    }
  });

  group('lets ordinary sharing through', () {
    for (final text in [
      'Diagnosed with type 2 last week. Still taking it in.',
      'I started insulin last month and feel scared.',
      'My father keeps skipping his evening walk.',
      'Swapped a full plate of rice for half rice, daal and salad.',
      'My fasting number was 126 this morning.',
      'Thank you all, this helped so much.',
    ]) {
      test(text, () => expect(ContentFilter.shouldHold(text), isFalse));
    }
  });
}
