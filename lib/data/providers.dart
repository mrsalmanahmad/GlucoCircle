import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'community_repository.dart';
import 'fireflies_repository.dart';
import 'inbox_repository.dart';
import 'models.dart';
import 'safety_repository.dart';
import 'sample_data.dart';
import 'session_controller.dart';

/// Launch country. Shown on glows instead of a city, see issue S6.
const launchCountry = 'Pakistan';

/// True only in debug builds, so sample people can't reach a release build.
final useSampleDataProvider = Provider<bool>((ref) => kDebugMode);

final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

final _signalProvider = Provider<ChangeSignal>((ref) => ChangeSignal());

final _inMemorySafetyProvider = Provider<InMemorySafetyRepository>(
  (ref) => InMemorySafetyRepository(ref.watch(_signalProvider)),
);

final _inMemoryInboxProvider = Provider<InMemoryInboxRepository>(
  (ref) => InMemoryInboxRepository(
    ref.watch(_signalProvider),
    ref.watch(clockProvider),
  ),
);

final _inMemoryCommunityProvider = Provider<InMemoryCommunityRepository>((ref) {
  return InMemoryCommunityRepository(
    signal: ref.watch(_signalProvider),
    safety: ref.watch(_inMemorySafetyProvider),
    currentUserId: () => ref.read(sessionProvider)?.userId,
    currentNickname: () => ref.read(sessionProvider)?.nickname,
    clock: ref.watch(clockProvider),
  );
});

final _inMemoryFirefliesProvider = Provider<InMemoryFirefliesRepository>((ref) {
  final inbox = ref.watch(_inMemoryInboxProvider);
  return InMemoryFirefliesRepository(
    signal: ref.watch(_signalProvider),
    safety: ref.watch(_inMemorySafetyProvider),
    currentUserId: () => ref.read(sessionProvider)?.userId,
    currentNickname: () => ref.read(sessionProvider)?.nickname,
    clock: ref.watch(clockProvider),
    country: launchCountry,
    onWarmthReceived: (who) => inbox.add(InboxType.warmth, who),
    sampleWarmth: ref.watch(useSampleDataProvider)
        ? const [
            (personId: 'sample-warm-1', nickname: 'Omar'),
            (personId: 'sample-warm-2', nickname: 'Fatima'),
          ]
        : const [],
  );
});

final _sampleDataLoader = Provider<void>((ref) {
  if (!ref.watch(useSampleDataProvider)) return;
  addSampleData(
    community: ref.watch(_inMemoryCommunityProvider),
    fireflies: ref.watch(_inMemoryFirefliesProvider),
    inbox: ref.watch(_inMemoryInboxProvider),
    now: ref.watch(clockProvider)(),
  );
});

// The screens and controllers only ever use the abstract types below. Pointing
// these at Firestore is how the temporary data gets replaced.

final safetyRepositoryProvider = Provider<SafetyRepository>(
  (ref) => ref.watch(_inMemorySafetyProvider),
);

final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  ref.watch(_sampleDataLoader);
  return ref.watch(_inMemoryCommunityProvider);
});

final firefliesRepositoryProvider = Provider<FirefliesRepository>((ref) {
  ref.watch(_sampleDataLoader);
  return ref.watch(_inMemoryFirefliesProvider);
});

final inboxRepositoryProvider = Provider<InboxRepository>((ref) {
  ref.watch(_sampleDataLoader);
  return ref.watch(_inMemoryInboxProvider);
});

/// Removes everything linked to the current person, for account deletion.
final forgetCurrentPersonProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    await ref.read(communityRepositoryProvider).deleteAllMine();
    await ref.read(firefliesRepositoryProvider).deleteAllMine();
    await ref.read(inboxRepositoryProvider).clear();
    final userId = ref.read(sessionProvider)?.userId;
    if (userId != null) ref.read(_inMemorySafetyProvider).forgetPerson(userId);
  };
});

final postsProvider = StreamProvider<List<Post>>(
  (ref) => ref.watch(communityRepositoryProvider).watchPosts(),
);

final repliesProvider = StreamProvider.family<List<Reply>, String>(
  (ref, postId) => ref.watch(communityRepositoryProvider).watchReplies(postId),
);

final glowsProvider = StreamProvider<List<Glow>>(
  (ref) => ref.watch(firefliesRepositoryProvider).watchGlows(),
);

final myGlowProvider = StreamProvider<MyGlow?>(
  (ref) => ref.watch(firefliesRepositoryProvider).watchMyGlow(),
);

final inboxProvider = StreamProvider<List<InboxItem>>(
  (ref) => ref.watch(inboxRepositoryProvider).watchItems(),
);

final blockedProvider = StreamProvider<List<BlockedPerson>>(
  (ref) => ref.watch(safetyRepositoryProvider).watchBlocked(),
);
