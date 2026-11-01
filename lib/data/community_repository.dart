import '../core/safety/content_filter.dart';
import 'models.dart';
import 'safety_repository.dart';

abstract class CommunityRepository {
  Stream<List<Post>> watchPosts();
  Stream<List<Reply>> watchReplies(String postId);
  Future<PublishOutcome> createPost({
    required Mood mood,
    required Topic topic,
    required String text,
    required bool anonymous,
  });
  Future<PublishOutcome> createReply(String postId, String text);
  Future<void> toggleRelate(String postId);
  Future<void> deletePost(String postId);
  Future<void> deleteReply(String replyId);
  Future<void> deleteAllMine();
}

/// TEMPORARY: replaced by Firestore. Anything held here is lost on restart.
class InMemoryCommunityRepository implements CommunityRepository {
  InMemoryCommunityRepository({
    required this._signal,
    required this._safety,
    required String? Function() currentUserId,
    required String? Function() currentNickname,
    required this._clock,
  }) : _userId = currentUserId,
       _nickname = currentNickname;

  final ChangeSignal _signal;
  final InMemorySafetyRepository _safety;
  final String? Function() _userId;
  final String? Function() _nickname;
  final DateTime Function() _clock;

  final _posts = <String, Post>{};
  final _replies = <String, Reply>{};
  final _held = <String>{};
  final _relates = <String, Set<String>>{};
  var _nextId = 0;

  String _newId(String prefix) => '$prefix-${_nextId++}';

  /// Adds someone else's post. Used only for debug sample data.
  void addSample(Post post, {required String personId}) {
    _posts[post.id] = post;
    _safety.linkAuthor(
      ReportTarget.post,
      post.id,
      personId: personId,
      label: post.authorName,
    );
  }

  /// Adds someone else's reply. Used only for debug sample data.
  void addSampleReply(Reply reply, {required String personId}) {
    _replies[reply.id] = reply;
    _safety.linkAuthor(
      ReportTarget.reply,
      reply.id,
      personId: personId,
      label: reply.authorName,
    );
  }

  bool _isVisible(ReportTarget target, String id) {
    final author = _safety.authorOf(target, id);
    if (author == _userId()) return true;
    if (_held.contains(id)) return false;
    if (_safety.isHiddenByReport(target, id)) return false;
    return !_safety.isBlocked(author);
  }

  bool _awaitingReview(ReportTarget target, String id) =>
      _held.contains(id) || _safety.isHiddenByReport(target, id);

  Post _view(Post post) {
    final me = _userId();
    final relates = _relates[post.id] ?? const {};
    return Post(
      id: post.id,
      authorName: post.authorName,
      mood: post.mood,
      topic: post.topic,
      text: post.text,
      createdAt: post.createdAt,
      relateCount: post.relateCount + relates.length,
      replyCount: _replies.values
          .where(
            (reply) =>
                reply.postId == post.id &&
                _isVisible(ReportTarget.reply, reply.id),
          )
          .length,
      relatedByMe: relates.contains(me),
      isMine: _safety.authorOf(ReportTarget.post, post.id) == me,
      awaitingReview: _awaitingReview(ReportTarget.post, post.id),
    );
  }

  @override
  Stream<List<Post>> watchPosts() {
    return _signal.watch(() {
      final visible = _posts.values
          .where((post) => _isVisible(ReportTarget.post, post.id))
          .map(_view)
          .toList();
      visible.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return visible;
    });
  }

  @override
  Stream<List<Reply>> watchReplies(String postId) {
    return _signal.watch(() {
      final me = _userId();
      final visible = _replies.values
          .where(
            (reply) =>
                reply.postId == postId &&
                _isVisible(ReportTarget.reply, reply.id),
          )
          .map(
            (reply) => Reply(
              id: reply.id,
              postId: reply.postId,
              authorName: reply.authorName,
              text: reply.text,
              createdAt: reply.createdAt,
              isMine: _safety.authorOf(ReportTarget.reply, reply.id) == me,
              awaitingReview: _awaitingReview(ReportTarget.reply, reply.id),
            ),
          )
          .toList();
      visible.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return visible;
    });
  }

  @override
  Future<PublishOutcome> createPost({
    required Mood mood,
    required Topic topic,
    required String text,
    required bool anonymous,
  }) async {
    final id = _newId('post');
    final name = _nickname();
    _posts[id] = Post(
      id: id,
      authorName: anonymous ? null : name,
      mood: mood,
      topic: topic,
      text: text,
      createdAt: _clock(),
    );
    _safety.linkAuthor(
      ReportTarget.post,
      id,
      personId: _userId()!,
      label: anonymous ? null : name,
    );
    return _publish(id, text);
  }

  @override
  Future<PublishOutcome> createReply(String postId, String text) async {
    final id = _newId('reply');
    final name = _nickname()!;
    _replies[id] = Reply(
      id: id,
      postId: postId,
      authorName: name,
      text: text,
      createdAt: _clock(),
    );
    _safety.linkAuthor(
      ReportTarget.reply,
      id,
      personId: _userId()!,
      label: name,
    );
    return _publish(id, text);
  }

  PublishOutcome _publish(String id, String text) {
    final hold = ContentFilter.shouldHold(text);
    if (hold) _held.add(id);
    _signal.notify();
    return hold ? PublishOutcome.heldForReview : PublishOutcome.published;
  }

  @override
  Future<void> toggleRelate(String postId) async {
    final me = _userId()!;
    final relates = _relates.putIfAbsent(postId, () => {});
    if (!relates.remove(me)) relates.add(me);
    _signal.notify();
  }

  @override
  Future<void> deletePost(String postId) async {
    _posts.remove(postId);
    _replies.removeWhere((_, reply) => reply.postId == postId);
    _signal.notify();
  }

  @override
  Future<void> deleteReply(String replyId) async {
    _replies.remove(replyId);
    _signal.notify();
  }

  @override
  Future<void> deleteAllMine() async {
    final me = _userId();
    _posts.removeWhere(
      (id, _) => _safety.authorOf(ReportTarget.post, id) == me,
    );
    _replies.removeWhere(
      (id, reply) =>
          _safety.authorOf(ReportTarget.reply, id) == me ||
          !_posts.containsKey(reply.postId),
    );
    for (final relates in _relates.values) {
      relates.remove(me);
    }
    _signal.notify();
  }
}
