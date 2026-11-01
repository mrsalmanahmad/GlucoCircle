import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucocircle/core/services/external_launcher.dart';

import 'helpers.dart';

Future<void> _openTab(
  WidgetTester tester,
  String tab, {
  ExternalLauncher? launcher,
}) async {
  tester.view.physicalSize = const Size(1170, 6000);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    testApp(
      overrides: [
        if (launcher != null)
          externalLauncherProvider.overrideWithValue(launcher),
      ],
    ),
  );
  await tester.pump();
  await tester.tap(find.text(tab));
  await settle(tester);
}

void main() {
  group('Signs', () {
    testWidgets('lists all 8 signs from the American Diabetes Association', (
      tester,
    ) async {
      await _openTab(tester, 'Signs');

      for (final sign in [
        'Very thirsty',
        'Urinating often',
        'Tired all the time',
        'Losing weight without trying',
        'Always hungry',
        'Blurry vision',
        'Cuts heal slowly',
        'Tingling hands or feet',
      ]) {
        expect(find.text(sign), findsOneWidget);
      }
      expect(find.text('Source: American Diabetes Association.'), findsOne);
    });

    testWidgets('is read-only: tapping a sign gives no personal result', (
      tester,
    ) async {
      await _openTab(tester, 'Signs');
      const consult =
          'Noticed any of these? Consult a doctor. They can arrange a fasting '
          'glucose or HbA1c test.';
      expect(find.text(consult), findsOneWidget);

      await tester.tap(find.text('Very thirsty'));
      await settle(tester);

      expect(find.text(consult), findsOneWidget);
      expect(find.textContaining('NOTICED'), findsNothing);
      expect(find.textContaining('see a doctor soon'), findsNothing);
    });

    testWidgets('shows the diagnostic ranges', (tester) async {
      await _openTab(tester, 'Signs');

      for (final value in [
        'under 100',
        '100–125',
        '126+',
        'under 5.7%',
        '5.7–6.4%',
        '6.5%+',
      ]) {
        expect(find.text(value), findsOneWidget);
      }
    });

    testWidgets('the emergency button dials 1122', (tester) async {
      Uri? opened;
      await _openTab(
        tester,
        'Signs',
        launcher: (uri) async {
          opened = uri;
          return true;
        },
      );

      await tester.tap(find.text('Call emergency 1122'));
      await settle(tester);

      expect(opened, Uri.parse('tel:1122'));
    });

    testWidgets('tells the person to dial if the phone cannot be opened', (
      tester,
    ) async {
      await _openTab(tester, 'Signs', launcher: (uri) async => false);

      await tester.tap(find.text('Call emergency 1122'));
      await tester.pump();

      expect(
        find.text("Couldn't open the phone. Please dial 1122 now."),
        findsOneWidget,
      );
    });

    testWidgets('Find a test opens a maps search', (tester) async {
      Uri? opened;
      await _openTab(
        tester,
        'Signs',
        launcher: (uri) async {
          opened = uri;
          return true;
        },
      );

      await tester.tap(find.text('Find a test near me'));
      await settle(tester);

      expect(opened!.host, 'www.google.com');
      expect(opened!.path, '/maps/search/');
      expect(opened!.queryParameters['query'], contains('diabetes'));
    });
  });

  group('Healthy', () {
    testWidgets('shows the plate, risks and get-checked card', (tester) async {
      await _openTab(tester, 'Healthy');

      expect(find.text('The healthy plate'), findsOneWidget);
      expect(find.text('Age 35 or older'), findsOneWidget);
      expect(find.text('South Asian family background'), findsOneWidget);
      expect(find.text('Get checked, even if you feel fine'), findsOneWidget);
      expect(find.textContaining('Ask your doctor'), findsOneWidget);
    });

    testWidgets('has no tracking or reminders', (tester) async {
      await _openTab(tester, 'Healthy');

      expect(find.text("Today's goals"), findsNothing);
      expect(find.textContaining('reminder'), findsNothing);
    });
  });
}
