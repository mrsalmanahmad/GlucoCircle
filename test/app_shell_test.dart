import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucocircle/app/app.dart';
import 'package:glucocircle/core/theme/app_colors.dart';
import 'package:glucocircle/core/theme/app_palette.dart';
import 'package:glucocircle/features/fireflies/fireflies_screen.dart';
import 'package:glucocircle/features/community/share_screen.dart';
import 'package:glucocircle/core/widgets/caution_text.dart';

const _caution =
    "General information and members' own experiences, not medical advice. "
    'Always consult your doctor.';

Future<void> _startApp(WidgetTester tester) async {
  await tester.pumpWidget(const ProviderScope(child: GlucoCircleApp()));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

// Fireflies pulse forever, so pumpAndSettle would never finish.
Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  testWidgets('opens on Community with exactly four tabs', (tester) async {
    await _startApp(tester);

    expect(find.text('You are not alone in this.'), findsOneWidget);
    expect(find.bySemanticsLabel('Community'), findsOneWidget);
    expect(find.bySemanticsLabel('Share'), findsOneWidget);
    expect(find.bySemanticsLabel('Signs'), findsOneWidget);
    expect(find.bySemanticsLabel('Healthy'), findsOneWidget);
    expect(find.bySemanticsLabel('Home'), findsNothing);
  });

  testWidgets(
    'a tab responds to taps anywhere in the bar, not just its label',
    (tester) async {
      await _startApp(tester);

      final label = tester.getBottomLeft(find.text('Signs'));
      await tester.tapAt(label + const Offset(4, 6));
      await _settle(tester);

      expect(find.text('Signs of diabetes'), findsOneWidget);
    },
  );

  testWidgets('Signs and Healthy open as tabs and show the caution', (
    tester,
  ) async {
    await _startApp(tester);

    await tester.tap(find.text('Signs'));
    await _settle(tester);
    expect(find.text('Signs of diabetes'), findsOneWidget);
    expect(find.text(_caution), findsOneWidget);

    await tester.tap(find.text('Healthy'));
    await _settle(tester);
    expect(find.text('Stay healthy'), findsOneWidget);
    expect(find.text(_caution), findsOneWidget);
  });

  testWidgets('Share opens full screen without the tabs, and can be closed', (
    tester,
  ) async {
    await _startApp(tester);

    await tester.tap(find.text('Share'));
    await _settle(tester);
    expect(find.byType(ShareScreen), findsOneWidget);
    expect(find.text('Healthy'), findsNothing);

    await tester.tap(find.text('Cancel'));
    await _settle(tester);
    expect(find.byType(ShareScreen), findsNothing);
    expect(find.text('Healthy'), findsOneWidget);
  });

  testWidgets('Fireflies uses the Night mood, Community stays Day', (
    tester,
  ) async {
    await _startApp(tester);

    final communityContext = tester.element(find.byType(CautionText));
    expect(communityContext.palette.background, DayColors.background);

    await tester.tap(find.text("Fireflies · who's awake now"));
    await _settle(tester);
    expect(find.byType(FirefliesScreen), findsOneWidget);

    final nightContext = tester.element(find.text('Fireflies'));
    expect(nightContext.palette.background, NightColors.background);
    expect(nightContext.palette.accent, NightColors.glow);
  });
}
