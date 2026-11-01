import 'dart:async';

import 'package:flutter/foundation.dart';

import 'models.dart';

/// Reports, blocks and the private link from content to its author.
///
/// The screens never see an author ID. They ask to block "the author of this
/// post", and the backend works out who that is.
abstract class SafetyRepository {
  Future<void> report(ReportTarget target, String id, ReportReason reason);
  Future<void> blockAuthor(ReportTarget target, String id);
  Future<void> unblock(String personId);
  Stream<List<BlockedPerson>> watchBlocked();
}

/// Emits whenever any temporary in-memory data changes.
class ChangeSignal {
  final _controller = StreamController<void>.broadcast();

  void notify() => _controller.add(null);

  Stream<T> watch<T>(T Function() read) {
    late final StreamController<T> output;
    StreamSubscription<void>? subscription;
    output = StreamController<T>(
      onListen: () {
        output.add(read());
        subscription = _controller.stream.listen((_) => output.add(read()));
      },
      onCancel: () => subscription?.cancel(),
    );
    return output.stream;
  }
}

/// TEMPORARY: replaced by Firestore. Anything held here is lost on restart.
class InMemorySafetyRepository implements SafetyRepository {
  InMemorySafetyRepository(this._signal);

  final ChangeSignal _signal;

  // Stands in for moderation/{targetId} in docs/MVP_PLAN.md, which only
  // moderators can read.
  final _authors = <(ReportTarget, String), ({String id, String? label})>{};
  final _blocked = <String, BlockedPerson>{};
  final _reports = <({ReportTarget target, String id, ReportReason reason})>[];

  @visibleForTesting
  List<({ReportTarget target, String id, ReportReason reason})> get reports =>
      List.unmodifiable(_reports);

  void linkAuthor(
    ReportTarget target,
    String id, {
    required String personId,
    required String? label,
  }) {
    _authors[(target, id)] = (id: personId, label: label);
  }

  String? authorOf(ReportTarget target, String id) =>
      _authors[(target, id)]?.id;

  bool isBlocked(String? personId) => _blocked.containsKey(personId);

  /// Reported "dangerous advice" is hidden from everyone until it's reviewed.
  bool isHiddenByReport(ReportTarget target, String id) {
    return _reports.any(
      (report) =>
          report.target == target &&
          report.id == id &&
          report.reason == ReportReason.dangerousAdvice,
    );
  }

  void forgetPerson(String personId) {
    _authors.removeWhere((_, author) => author.id == personId);
    _blocked.clear();
    _signal.notify();
  }

  @override
  Future<void> report(
    ReportTarget target,
    String id,
    ReportReason reason,
  ) async {
    _reports.add((target: target, id: id, reason: reason));
    _signal.notify();
  }

  @override
  Future<void> blockAuthor(ReportTarget target, String id) async {
    final author = _authors[(target, id)];
    if (author == null) return;
    _blocked[author.id] = BlockedPerson(
      personId: author.id,
      label: author.label,
    );
    _signal.notify();
  }

  @override
  Future<void> unblock(String personId) async {
    _blocked.remove(personId);
    _signal.notify();
  }

  @override
  Stream<List<BlockedPerson>> watchBlocked() {
    return _signal.watch(() => _blocked.values.toList());
  }
}
