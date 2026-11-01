import 'community_repository.dart';
import 'fireflies_repository.dart';
import 'inbox_repository.dart';
import 'models.dart';

/// DEBUG ONLY. These people are not real, so this must never reach a release
/// build. Showing invented people to real users is issue S5 in
/// docs/wireframes/README.md. [useSampleDataProvider] enforces this.
void addSampleData({
  required InMemoryCommunityRepository community,
  required InMemoryFirefliesRepository fireflies,
  required InMemoryInboxRepository inbox,
  required DateTime now,
}) {
  DateTime ago({int minutes = 0, int hours = 0, int days = 0}) =>
      now.subtract(Duration(minutes: minutes, hours: hours, days: days));

  community
    ..addSample(
      Post(
        id: 'sample-post-1',
        authorName: 'Hamza K.',
        mood: Mood.low,
        topic: Topic.newlyDiagnosed,
        text:
            'Diagnosed with type 2 last week. Still taking it in. How did you '
            'all get through the first month?',
        createdAt: ago(hours: 2),
        relateCount: 24,
      ),
      personId: 'sample-hamza',
    )
    ..addSample(
      Post(
        id: 'sample-post-2',
        authorName: 'Sana N.',
        mood: Mood.good,
        topic: Topic.food,
        text:
            'Swapped a full plate of rice for half rice, daal and salad. '
            'Feeling much better after lunch.',
        createdAt: ago(hours: 5),
        relateCount: 41,
      ),
      personId: 'sample-sana',
    )
    ..addSample(
      Post(
        id: 'sample-post-3',
        authorName: null,
        mood: Mood.struggling,
        topic: Topic.caregivers,
        text:
            'My father keeps skipping his evening walk. Any tips for keeping '
            'elders motivated without nagging?',
        createdAt: ago(days: 1),
        relateCount: 17,
      ),
      personId: 'sample-anon',
    )
    ..addSampleReply(
      Reply(
        id: 'sample-reply-1',
        postId: 'sample-post-1',
        authorName: 'Sana N.',
        text: 'The first month was the hardest for me too. You are not alone.',
        createdAt: ago(hours: 1),
      ),
      personId: 'sample-sana',
    );

  for (final (index, sample) in const [
    (GlowFeeling.afterLow, 'Fatima', "Woke up shaky and now I can't sleep."),
    (GlowFeeling.cantSleep, 'Omar', 'Up for the third time tonight.'),
    (GlowFeeling.newDiagnosis, 'Priya', "I haven't told my family yet."),
    (GlowFeeling.feelingHeavy, 'Rahim', 'Some nights it is just a lot.'),
    (GlowFeeling.justCompany, 'Ali', ''),
  ].indexed) {
    final (feeling, name, line) = sample;
    fireflies.addSample(
      Glow(
        id: 'sample-glow-$index',
        nickname: name,
        country: fireflies.country,
        feeling: feeling,
        line: line,
        startedAt: ago(minutes: 8 + index * 11),
        expiresAt: now.add(const Duration(hours: 2)),
      ),
      personId: 'sample-glow-person-$index',
    );
  }

  inbox.add(
    InboxType.reply,
    'Sana N.',
    postId: 'sample-post-1',
    at: ago(hours: 1),
  );
}
