import 'package:flutter/foundation.dart';

enum Mood { good, okay, low, struggling }

enum Topic {
  newlyDiagnosed,
  type1,
  type2,
  gestational,
  food,
  caregivers,
  exercise,
}

/// Topics someone follows. Never store these as a diagnosis.
enum Interest {
  type1(Topic.type1),
  type2(Topic.type2),
  prediabetes(null),
  pregnancy(Topic.gestational),
  caring(Topic.caregivers),
  stayingHealthy(null);

  const Interest(this.topic);

  final Topic? topic;
}

enum ReportTarget { post, reply, glow, warmth }

enum ReportReason { dangerousAdvice, selling, bullying, danger, spam }

enum PublishOutcome { published, heldForReview }

enum GlowFeeling {
  cantSleep,
  afterLow,
  sugarHigh,
  newDiagnosis,
  feelingHeavy,
  justCompany;

  /// These show the caution step before the glow is lit.
  bool get needsCaution => this == afterLow || this == sugarHigh;
}

enum GlowDuration { min15, min30, hour1, tillDawn }

@immutable
class Session {
  const Session({
    required this.userId,
    this.nickname,
    this.consented = false,
    this.onboarded = false,
    this.interests = const {},
  });

  final String userId;
  final String? nickname;
  final bool consented;
  final bool onboarded;
  final Set<Interest> interests;

  Session copyWith({
    String? nickname,
    bool? consented,
    bool? onboarded,
    Set<Interest>? interests,
  }) {
    return Session(
      userId: userId,
      nickname: nickname ?? this.nickname,
      consented: consented ?? this.consented,
      onboarded: onboarded ?? this.onboarded,
      interests: interests ?? this.interests,
    );
  }
}

/// What every member can read. It deliberately has no author ID, so an
/// anonymous post can't be traced by reading it. See docs/MVP_PLAN.md.
@immutable
class Post {
  const Post({
    required this.id,
    required this.authorName,
    required this.mood,
    required this.topic,
    required this.text,
    required this.createdAt,
    this.relateCount = 0,
    this.replyCount = 0,
    this.relatedByMe = false,
    this.isMine = false,
    this.awaitingReview = false,
  });

  final String id;

  /// Null when the post is anonymous.
  final String? authorName;
  final Mood mood;
  final Topic topic;
  final String text;
  final DateTime createdAt;
  final int relateCount;
  final int replyCount;
  final bool relatedByMe;
  final bool isMine;

  /// Only ever true for the author. Nobody else receives the post.
  final bool awaitingReview;
}

@immutable
class Reply {
  const Reply({
    required this.id,
    required this.postId,
    required this.authorName,
    required this.text,
    required this.createdAt,
    this.isMine = false,
    this.awaitingReview = false,
  });

  final String id;
  final String postId;
  final String authorName;
  final String text;
  final DateTime createdAt;
  final bool isMine;
  final bool awaitingReview;
}

@immutable
class Glow {
  const Glow({
    required this.id,
    required this.nickname,
    required this.country,
    required this.feeling,
    required this.line,
    required this.startedAt,
    required this.expiresAt,
    this.warmedByMe = false,
  });

  final String id;
  final String nickname;
  final String country;
  final GlowFeeling feeling;
  final String line;
  final DateTime startedAt;
  final DateTime expiresAt;
  final bool warmedByMe;
}

@immutable
class Warmth {
  const Warmth({
    required this.id,
    required this.nickname,
    required this.country,
    required this.createdAt,
    this.glowedBack = false,
  });

  final String id;
  final String nickname;
  final String country;
  final DateTime createdAt;
  final bool glowedBack;
}

@immutable
class MyGlow {
  const MyGlow({required this.glow, required this.warmth});

  final Glow glow;
  final List<Warmth> warmth;
}

enum InboxType { reply, warmth }

@immutable
class InboxItem {
  const InboxItem({
    required this.id,
    required this.type,
    required this.who,
    required this.createdAt,
    this.postId,
  });

  final String id;
  final InboxType type;
  final String who;
  final DateTime createdAt;
  final String? postId;
}

@immutable
class BlockedPerson {
  const BlockedPerson({required this.personId, required this.label});

  final String personId;

  /// Null when they were blocked from an anonymous post.
  final String? label;
}
