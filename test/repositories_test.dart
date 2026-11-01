import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucocircle/data/fireflies_repository.dart';
import 'package:glucocircle/data/models.dart';
import 'package:glucocircle/data/providers.dart';
import 'package:glucocircle/data/session_controller.dart';

import 'helpers.dart';

ProviderContainer _container({
  Session? session = signedIn,
  bool sampleData = false,
  DateTime Function()? clock,
}) {
  final container = ProviderContainer(
    overrides: [
      initialSessionProvider.overrideWithValue(session),
      useSampleDataProvider.overrideWithValue(sampleData),
      if (clock != null) clockProvider.overrideWithValue(clock),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

Future<List<Post>> _posts(ProviderContainer c) =>
    c.read(communityRepositoryProvider).watchPosts().first;

Future<List<Glow>> _glows(ProviderContainer c) =>
    c.read(firefliesRepositoryProvider).watchGlows().first;

void main() {
  group('sample data', () {
    test('nothing appears unless sample data is switched on', () async {
      final container = _container();
      expect(await _posts(container), isEmpty);
      expect(await _glows(container), isEmpty);
    });
  });

  group('anonymous posts', () {
    test('never carry a name, and the model has no author field', () async {
      final container = _container();
      await container
          .read(communityRepositoryProvider)
          .createPost(
            mood: Mood.low,
            topic: Topic.type2,
            text: 'Scared to tell my family.',
            anonymous: true,
          );
      final post = (await _posts(container)).single;
      expect(post.authorName, isNull);
      expect(post.isMine, isTrue);
    });
  });

  group('content filter', () {
    test('a held post is only visible to its author', () async {
      final container = _container();
      final outcome = await container
          .read(communityRepositoryProvider)
          .createPost(
            mood: Mood.good,
            topic: Topic.food,
            text: 'Stop your insulin, DM me',
            anonymous: false,
          );
      expect(outcome, PublishOutcome.heldForReview);
      expect((await _posts(container)).single.awaitingReview, isTrue);

      // Seen by someone else, it isn't there at all.
      container.read(sessionProvider.notifier).signOut();
      expect(await _posts(container), isEmpty);
    });

    test('a held glow line is not lit', () async {
      final container = _container();
      final outcome = await container
          .read(firefliesRepositoryProvider)
          .lightGlow(
            feeling: GlowFeeling.cantSleep,
            line: 'call me on 0300 1234567',
            duration: GlowDuration.min15,
          );
      expect(outcome, PublishOutcome.heldForReview);
      final mine = await container
          .read(firefliesRepositoryProvider)
          .watchMyGlow()
          .first;
      expect(mine, isNull);
    });
  });

  group('report and block', () {
    test('reported dangerous advice is hidden from everyone', () async {
      final container = _container(sampleData: true);
      final before = await _posts(container);
      await container
          .read(safetyRepositoryProvider)
          .report(
            ReportTarget.post,
            before.first.id,
            ReportReason.dangerousAdvice,
          );
      final after = await _posts(container);
      expect(after.map((post) => post.id), isNot(contains(before.first.id)));
    });

    test('other report reasons leave the post up for review', () async {
      final container = _container(sampleData: true);
      final before = await _posts(container);
      await container
          .read(safetyRepositoryProvider)
          .report(ReportTarget.post, before.first.id, ReportReason.spam);
      expect(await _posts(container), hasLength(before.length));
    });

    test('blocking hides that person, even when they were anonymous', () async {
      final container = _container(sampleData: true);
      final safety = container.read(safetyRepositoryProvider);
      final anonymous = (await _posts(container))
          .firstWhere((post) => post.authorName == null);

      await safety.blockAuthor(ReportTarget.post, anonymous.id);

      expect(
        (await _posts(container)).map((post) => post.id),
        isNot(contains(anonymous.id)),
      );
      final blocked = await safety.watchBlocked().first;
      expect(blocked.single.label, isNull);

      await safety.unblock(blocked.single.personId);
      expect(
        (await _posts(container)).map((post) => post.id),
        contains(anonymous.id),
      );
    });

    test('blocking hides their glows too', () async {
      final container = _container(sampleData: true);
      final glow = (await _glows(container)).first;
      await container
          .read(safetyRepositoryProvider)
          .blockAuthor(ReportTarget.glow, glow.id);
      expect(
        (await _glows(container)).map((item) => item.id),
        isNot(contains(glow.id)),
      );
    });
  });

  group('glows', () {
    test('disappear at expiry, even before auto-delete runs', () async {
      var now = DateTime(2026, 11, 2, 3);
      final container = _container(clock: () => now);
      final repository = container.read(firefliesRepositoryProvider);
      await repository.lightGlow(
        feeling: GlowFeeling.cantSleep,
        line: '',
        duration: GlowDuration.min15,
      );
      expect(await repository.watchMyGlow().first, isNotNull);

      now = now.add(const Duration(minutes: 16));
      expect(await repository.watchMyGlow().first, isNull);
    });

    test('expired sample glows leave the sky', () async {
      var now = DateTime(2026, 11, 2, 3);
      final container = _container(sampleData: true, clock: () => now);
      expect(await _glows(container), isNotEmpty);
      now = now.add(const Duration(hours: 3));
      expect(await _glows(container), isEmpty);
    });

    test('till dawn ends at the next 6 AM', () {
      expect(
        glowExpiry(DateTime(2026, 11, 2, 3), GlowDuration.tillDawn),
        DateTime(2026, 11, 2, 6),
      );
      expect(
        glowExpiry(DateTime(2026, 11, 2, 23), GlowDuration.tillDawn),
        DateTime(2026, 11, 3, 6),
      );
    });

    test('only low and high sugar feelings need the caution step', () {
      expect(GlowFeeling.values.where((feeling) => feeling.needsCaution), [
        GlowFeeling.afterLow,
        GlowFeeling.sugarHigh,
      ]);
    });
  });

  group('delete account', () {
    test('removes everything and signs out', () async {
      final container = _container();
      await container
          .read(communityRepositoryProvider)
          .createPost(
            mood: Mood.good,
            topic: Topic.food,
            text: 'Hello',
            anonymous: true,
          );
      await container
          .read(firefliesRepositoryProvider)
          .lightGlow(
            feeling: GlowFeeling.cantSleep,
            line: '',
            duration: GlowDuration.min15,
          );

      await container.read(sessionProvider.notifier).deleteAccount();

      expect(container.read(sessionProvider), isNull);
      expect(await _posts(container), isEmpty);
    });
  });
}
