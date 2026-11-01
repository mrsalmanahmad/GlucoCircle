import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucocircle/app/router.dart';
import 'package:glucocircle/app/routes.dart';
import 'package:glucocircle/data/models.dart';
import 'package:glucocircle/features/fireflies/glow_caution_screen.dart';
import 'package:glucocircle/features/fireflies/quiet_glow_screen.dart';

import 'helpers.dart';

Future<void> _start(
  WidgetTester tester, {
  Session? session = signedIn,
  bool sampleData = false,
}) async {
  useTallScreen(tester);
  await tester.pumpWidget(testApp(session: session, sampleData: sampleData));
  await settle(tester);
}

Future<void> _tap(WidgetTester tester, String text) async {
  await _tapFinder(tester, find.text(text));
}

Future<void> _tapFinder(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
  await settle(tester);
}

void main() {
  group('setup redirect', () {
    const consented = Session(userId: 'me', nickname: 'A', consented: true);

    test('signed out people can only reach the welcome screens', () {
      expect(setupRedirect(null, Routes.community), Routes.welcome);
      expect(setupRedirect(null, Routes.welcome), isNull);
      expect(setupRedirect(null, Routes.emailSignIn), isNull);
    });

    test('nobody skips consent', () {
      const session = Session(userId: 'me');
      expect(setupRedirect(session, Routes.community), Routes.consent);
      expect(setupRedirect(session, Routes.onboarding), Routes.consent);
    });

    test('onboarding comes after consent, then the app', () {
      expect(setupRedirect(consented, Routes.community), Routes.onboarding);
      expect(setupRedirect(signedIn, Routes.welcome), Routes.community);
      expect(setupRedirect(signedIn, Routes.fireflies), isNull);
    });
  });

  group('joining', () {
    testWidgets('email, consent, topics, then Community', (tester) async {
      await _start(tester, session: null);
      expect(find.text('Continue with Google'), findsOneWidget);

      await _tap(tester, 'Continue with email');
      await tester.enterText(find.byType(TextField).at(0), 'not-an-email');
      await tester.enterText(find.byType(TextField).at(1), 'short');
      await _tap(tester, 'Continue');
      expect(find.text('Please enter a valid email address.'), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), 'a@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'long-enough');
      await _tap(tester, 'Continue');

      // Consent can't be passed until everything is done.
      expect(find.text('Before you join'), findsOneWidget);
      await _tap(tester, 'Continue');
      expect(find.text('Before you join'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Ayesha');
      await tester.pump();
      await _tap(tester, 'I am 18 or older.');
      await tester.tap(find.byType(CheckboxListTile).last);
      await settle(tester);
      await _tap(tester, 'Continue');

      expect(find.text('What brings you to GlucoCircle?'), findsOneWidget);
      expect(find.textContaining('I have'), findsNothing);
      await _tap(tester, 'Skip');

      expect(find.text('You are not alone in this.'), findsOneWidget);
    });
  });

  group('community', () {
    testWidgets('an honest empty feed when there are no posts', (tester) async {
      await _start(tester);
      expect(find.text('Be the first to share'), findsOneWidget);
    });

    testWidgets('sharing puts your post in the feed', (tester) async {
      await _start(tester);
      await _tap(tester, 'Share your story');

      // Post stays off until there's text and a topic.
      final post = find.widgetWithText(FilledButton, 'Post');
      expect(tester.widget<FilledButton>(post).onPressed, isNull);

      await tester.enterText(find.byType(TextField), 'Had a better week.');
      await _tap(tester, 'Food');
      await tester.tap(post);
      await settle(tester);

      expect(find.text('Had a better week.'), findsOneWidget);
      expect(find.text('Ayesha'), findsOneWidget);
    });

    testWidgets('topic chips sit side by side, not full width', (tester) async {
      await _start(tester);
      await _tap(tester, 'Share your story');
      final chip = tester.getSize(find.text('Food').first);
      final box = tester.getSize(
        find
            .ancestor(
              of: find.text('Food').first,
              matching: find.byType(Container),
            )
            .first,
      );
      expect(box.width, lessThan(chip.width + 40));
    });

    testWidgets('anonymous posts hide the name', (tester) async {
      await _start(tester);
      await _tap(tester, 'Share your story');
      await tester.enterText(find.byType(TextField), 'Hard to say this.');
      await _tap(tester, 'Food');
      await tester.tap(find.bySemanticsLabel('Post anonymously').last);
      await settle(tester);
      await _tap(tester, 'Post');

      expect(find.text('Hard to say this.'), findsOneWidget);
      expect(find.text('Anonymous'), findsOneWidget);
      expect(find.text('Ayesha'), findsNothing);
    });

    testWidgets('risky posts are held and the author is told', (tester) async {
      await _start(tester);
      await _tap(tester, 'Share your story');
      await tester.enterText(find.byType(TextField), 'Stop your insulin now');
      await _tap(tester, 'Food');
      await _tap(tester, 'Post');

      expect(find.textContaining('A moderator will check'), findsOneWidget);
      expect(find.textContaining('Only you can see this'), findsOneWidget);
    });

    testWidgets('topic filter narrows the feed', (tester) async {
      await _start(tester, sampleData: true);
      expect(find.textContaining('Hamza'), findsOneWidget);
      await _tapFinder(tester, find.text('Food').first);
      expect(find.textContaining('Hamza'), findsNothing);
      expect(find.text('Sana N.'), findsOneWidget);
    });

    testWidgets('I relate toggles the count', (tester) async {
      await _start(tester, sampleData: true);
      await _tap(tester, 'I relate · 41');
      expect(find.text('I relate · 42'), findsOneWidget);
      await _tap(tester, 'I relate · 42');
      expect(find.text('I relate · 41'), findsOneWidget);
    });

    testWidgets('replying from the post detail', (tester) async {
      await _start(tester, sampleData: true);
      await _tap(tester, '1 reply');
      expect(find.textContaining('You are not alone'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Thinking of you.');
      await tester.tap(find.byTooltip('Send reply'));
      await settle(tester);

      expect(find.text('Thinking of you.'), findsOneWidget);
      expect(find.text('2 replies'), findsOneWidget);
    });

    testWidgets('report: reasons, then the sent message', (tester) async {
      await _start(tester, sampleData: true);
      await tester.tap(find.byTooltip('Options').first);
      await settle(tester);
      await _tap(tester, 'Report');

      expect(find.text('Report this post'), findsOneWidget);
      expect(find.text('Someone may be in danger'), findsOneWidget);
      await _tap(tester, 'Send report');

      expect(find.text('Thanks for keeping the circle safe'), findsOneWidget);
      expect(find.textContaining('within 24 hours'), findsOneWidget);
      expect(find.textContaining('[REVIEW TIME]'), findsNothing);
    });

    testWidgets('sheets cover the bottom tabs, so nothing is cut off', (
      tester,
    ) async {
      await _start(tester, sampleData: true);
      await tester.tap(find.byTooltip('Options').first);
      await settle(tester);

      final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
      expect(tester.getRect(find.byType(BottomSheet)).bottom, screen.height);
    });

    testWidgets('someone in danger: the emergency number comes first', (
      tester,
    ) async {
      await _start(tester, sampleData: true);
      await tester.tap(find.byTooltip('Options').first);
      await settle(tester);
      await _tap(tester, 'Report');
      await _tap(tester, 'Someone may be in danger');
      await _tap(tester, 'Send report');

      expect(find.textContaining("don't wait for us"), findsOneWidget);
      expect(find.text('Call emergency 1122'), findsOneWidget);
    });

    testWidgets('block removes them, and Settings can undo it', (tester) async {
      await _start(tester, sampleData: true);
      final name = find.text('Hamza K.');
      expect(name, findsOneWidget);

      await tester.tap(find.byTooltip('Options').first);
      await settle(tester);
      await _tap(tester, 'Block this person');
      expect(find.text('Block this person?'), findsOneWidget);
      await tester.tap(find.text('Block this person').last);
      await settle(tester);
      expect(name, findsNothing);

      await tester.tap(find.bySemanticsLabel('Settings'));
      await settle(tester);
      await _tap(tester, 'Blocked people');
      expect(name, findsOneWidget);
      await _tap(tester, 'Unblock');
      expect(find.text('No one is blocked'), findsOneWidget);
    });

    testWidgets('you can delete your own post, not report it', (tester) async {
      await _start(tester);
      await _tap(tester, 'Share your story');
      await tester.enterText(find.byType(TextField), 'Mine to remove.');
      await _tap(tester, 'Food');
      await _tap(tester, 'Post');

      await tester.tap(find.byTooltip('Options'));
      await settle(tester);
      expect(find.text('Report'), findsNothing);
      await _tap(tester, 'Delete');

      expect(find.text('Mine to remove.'), findsNothing);
    });
  });

  group('settings', () {
    testWidgets('delete account confirms, then signs out', (tester) async {
      await _start(tester);
      await tester.tap(find.bySemanticsLabel('Settings'));
      await settle(tester);
      await _tap(tester, 'Delete account');
      expect(find.textContaining("can't be undone"), findsOneWidget);
      await _tap(tester, 'Delete my account');
      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('sign out goes back to welcome', (tester) async {
      await _start(tester);
      await tester.tap(find.bySemanticsLabel('Settings'));
      await settle(tester);
      await _tap(tester, 'Sign out');
      expect(find.text('Continue with Google'), findsOneWidget);
    });
  });

  group('fireflies', () {
    Future<void> openSky(WidgetTester tester, {bool sample = false}) async {
      await _start(tester, sampleData: sample);
      await tester.tap(find.text("Fireflies · who's awake now"));
      await settle(tester);
    }

    testWidgets('an empty sky says so, and shows no invented people', (
      tester,
    ) async {
      await openSky(tester);
      expect(find.textContaining("You're the first firefly"), findsOneWidget);
      expect(find.text('Send warmth'), findsNothing);
    });

    testWidgets('the count is real and warmth can be sent once', (
      tester,
    ) async {
      await openSky(tester, sample: true);
      expect(find.textContaining('5 people feel like you'), findsOneWidget);
      await _tap(tester, 'Send warmth');
      expect(find.text('Warmth sent'), findsOneWidget);
    });

    testWidgets('someone waiting a long time does not break the sky', (
      tester,
    ) async {
      // Sample glows go up to 52 minutes, past the brightness limit.
      await openSky(tester, sample: true);
      expect(tester.takeException(), isNull);
    });

    testWidgets('there is no chat, matching or constellation in Lite', (
      tester,
    ) async {
      await openSky(tester, sample: true);
      expect(find.text('Talk'), findsNothing);
      expect(find.textContaining('constellation'), findsNothing);

      await _tap(tester, 'Light my glow');
      expect(find.text('How do you want to connect?'), findsNothing);
      expect(find.text('Match me with'), findsNothing);
    });

    testWidgets('a calm feeling goes straight to the quiet glow', (
      tester,
    ) async {
      await openSky(tester);
      await _tap(tester, 'Light my glow');
      await _tap(tester, "Can't sleep");
      await _tap(tester, 'Glow quietly');

      expect(find.byType(GlowCautionScreen), findsNothing);
      expect(find.byType(QuietGlowScreen), findsOneWidget);
      expect(find.text("You're glowing quietly"), findsOneWidget);
    });

    testWidgets('after a low: a caution, with no blood sugar question', (
      tester,
    ) async {
      await openSky(tester);
      await _tap(tester, 'Light my glow');
      await _tapFinder(tester, find.text('After a low').last);
      await _tap(tester, 'Glow quietly');

      expect(find.byType(GlowCautionScreen), findsOneWidget);
      expect(find.text('Call emergency 1122'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
      expect(find.textContaining('mg/dL'), findsNothing);
      expect(find.textContaining('15'), findsNothing);
      expect(find.textContaining('safe range'), findsNothing);

      await _tap(tester, "I'm okay, continue");
      expect(find.byType(QuietGlowScreen), findsOneWidget);
    });

    testWidgets('a risky line is sent back to be reworded', (tester) async {
      await openSky(tester);
      await _tap(tester, 'Light my glow');
      await _tapFinder(tester, find.text('After a low').last);
      await tester.enterText(find.byType(TextField), 'whatsapp me');
      await tester.pump();
      await _tap(tester, 'Glow quietly');
      await _tap(tester, "I'm okay, continue");

      expect(find.byType(QuietGlowScreen), findsNothing);
      expect(find.textContaining('Please reword'), findsOneWidget);
    });

    testWidgets('warmth arrives, glow back works, dim ends it', (tester) async {
      await openSky(tester, sample: true);
      await _tap(tester, 'Light my glow');
      await _tap(tester, "Can't sleep");
      await _tap(tester, 'Glow quietly');

      expect(find.text('2 people sent you warmth'), findsOneWidget);
      await tester.tap(find.text('Glow back').first);
      await settle(tester);
      expect(find.text('Glow back'), findsOneWidget);

      await _tap(tester, 'Dim my glow');
      expect(find.text('Light my glow'), findsOneWidget);
    });
  });
}
