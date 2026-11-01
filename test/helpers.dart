import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucocircle/app/app.dart';
import 'package:glucocircle/data/models.dart';
import 'package:glucocircle/data/providers.dart';
import 'package:glucocircle/data/session_controller.dart';

const signedIn = Session(
  userId: 'me',
  nickname: 'Ayesha',
  consented: true,
  onboarded: true,
);

/// The whole app. Starts signed in, with no sample data unless asked.
Widget testApp({
  Session? session = signedIn,
  bool sampleData = false,
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: [
      initialSessionProvider.overrideWithValue(session),
      useSampleDataProvider.overrideWithValue(sampleData),
      ...overrides,
    ],
    child: const GlucoCircleApp(),
  );
}

/// Fireflies pulse forever, so pumpAndSettle would never finish.
Future<void> settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump(const Duration(milliseconds: 500));
}

void useTallScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(1170, 6000);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}
