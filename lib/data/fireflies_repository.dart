import '../core/safety/content_filter.dart';
import 'models.dart';
import 'safety_repository.dart';

abstract class FirefliesRepository {
  /// Other people's glows that haven't expired.
  Stream<List<Glow>> watchGlows();
  Stream<MyGlow?> watchMyGlow();

  /// A held line is not lit, because a glow is only useful right now. The
  /// person is asked to reword it instead.
  Future<PublishOutcome> lightGlow({
    required GlowFeeling feeling,
    required String line,
    required GlowDuration duration,
  });
  Future<void> dimMyGlow();
  Future<void> sendWarmth(String glowId);
  Future<void> glowBack(String warmthId);
  Future<void> deleteAllMine();
}

/// When a glow ends. "Till dawn" means the next 6 AM.
DateTime glowExpiry(DateTime now, GlowDuration duration) {
  return switch (duration) {
    GlowDuration.min15 => now.add(const Duration(minutes: 15)),
    GlowDuration.min30 => now.add(const Duration(minutes: 30)),
    GlowDuration.hour1 => now.add(const Duration(hours: 1)),
    GlowDuration.tillDawn => _nextDawn(now),
  };
}

DateTime _nextDawn(DateTime now) {
  final today = DateTime(now.year, now.month, now.day, 6);
  return now.isBefore(today) ? today : today.add(const Duration(days: 1));
}

/// TEMPORARY: replaced by Firestore. Anything held here is lost on restart.
class InMemoryFirefliesRepository implements FirefliesRepository {
  InMemoryFirefliesRepository({
    required this._signal,
    required this._safety,
    required String? Function() currentUserId,
    required String? Function() currentNickname,
    required this._clock,
    required this.country,
    this.onWarmthReceived,
    this.sampleWarmth = const [],
  }) : _userId = currentUserId,
       _nickname = currentNickname;

  final ChangeSignal _signal;
  final InMemorySafetyRepository _safety;
  final String? Function() _userId;
  final String? Function() _nickname;
  final DateTime Function() _clock;
  final String country;
  final void Function(String who)? onWarmthReceived;

  /// Debug only: who "sends warmth" when you light a glow.
  final List<({String personId, String nickname})> sampleWarmth;

  final _glows = <String, Glow>{};
  final _warmedByMe = <String>{};
  final _warmth = <String, Warmth>{};
  var _nextId = 0;

  /// Adds someone else's glow. Used only for debug sample data.
  void addSample(Glow glow, {required String personId}) {
    _glows[glow.id] = glow;
    _safety.linkAuthor(
      ReportTarget.glow,
      glow.id,
      personId: personId,
      label: glow.nickname,
    );
  }

  String? get _myGlowId {
    final me = _userId();
    for (final glow in _glows.values) {
      if (_safety.authorOf(ReportTarget.glow, glow.id) == me &&
          glow.expiresAt.isAfter(_clock())) {
        return glow.id;
      }
    }
    return null;
  }

  @override
  Stream<List<Glow>> watchGlows() {
    return _signal.watch(() {
      final now = _clock();
      final me = _userId();
      final visible = <Glow>[];
      for (final glow in _glows.values) {
        final author = _safety.authorOf(ReportTarget.glow, glow.id);
        // Auto-delete can run a day late, so expiry is always checked here.
        if (!glow.expiresAt.isAfter(now)) continue;
        if (author == me || _safety.isBlocked(author)) continue;
        if (_safety.isHiddenByReport(ReportTarget.glow, glow.id)) continue;
        visible.add(
          Glow(
            id: glow.id,
            nickname: glow.nickname,
            country: glow.country,
            feeling: glow.feeling,
            line: glow.line,
            startedAt: glow.startedAt,
            expiresAt: glow.expiresAt,
            warmedByMe: _warmedByMe.contains(glow.id),
          ),
        );
      }
      visible.sort((a, b) => a.startedAt.compareTo(b.startedAt));
      return visible;
    });
  }

  @override
  Stream<MyGlow?> watchMyGlow() {
    return _signal.watch(() {
      final id = _myGlowId;
      if (id == null) return null;
      final warmth =
          _warmth.values
              .where(
                (warm) => !_safety.isBlocked(
                  _safety.authorOf(ReportTarget.warmth, warm.id),
                ),
              )
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return MyGlow(glow: _glows[id]!, warmth: warmth);
    });
  }

  @override
  Future<PublishOutcome> lightGlow({
    required GlowFeeling feeling,
    required String line,
    required GlowDuration duration,
  }) async {
    if (ContentFilter.shouldHold(line)) return PublishOutcome.heldForReview;
    await dimMyGlow();
    final now = _clock();
    final id = 'glow-${_nextId++}';
    _glows[id] = Glow(
      id: id,
      nickname: _nickname()!,
      country: country,
      feeling: feeling,
      line: line,
      startedAt: now,
      expiresAt: glowExpiry(now, duration),
    );
    _safety.linkAuthor(
      ReportTarget.glow,
      id,
      personId: _userId()!,
      label: _nickname(),
    );
    for (final sample in sampleWarmth) {
      final warmthId = 'warmth-${_nextId++}';
      _warmth[warmthId] = Warmth(
        id: warmthId,
        nickname: sample.nickname,
        country: country,
        createdAt: now,
      );
      _safety.linkAuthor(
        ReportTarget.warmth,
        warmthId,
        personId: sample.personId,
        label: sample.nickname,
      );
      onWarmthReceived?.call(sample.nickname);
    }
    _signal.notify();
    return PublishOutcome.published;
  }

  @override
  Future<void> dimMyGlow() async {
    final id = _myGlowId;
    if (id != null) _glows.remove(id);
    _warmth.clear();
    _signal.notify();
  }

  @override
  Future<void> sendWarmth(String glowId) async {
    _warmedByMe.add(glowId);
    _signal.notify();
  }

  @override
  Future<void> glowBack(String warmthId) async {
    final warm = _warmth[warmthId];
    if (warm == null) return;
    _warmth[warmthId] = Warmth(
      id: warm.id,
      nickname: warm.nickname,
      country: warm.country,
      createdAt: warm.createdAt,
      glowedBack: true,
    );
    _signal.notify();
  }

  @override
  Future<void> deleteAllMine() async {
    final me = _userId();
    _glows.removeWhere(
      (id, _) => _safety.authorOf(ReportTarget.glow, id) == me,
    );
    _warmth.clear();
    _warmedByMe.clear();
    _signal.notify();
  }
}
