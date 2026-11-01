import 'models.dart';
import 'safety_repository.dart';

abstract class InboxRepository {
  Stream<List<InboxItem>> watchItems();
  Future<void> clear();
}

/// TEMPORARY: replaced by Firestore. Anything held here is lost on restart.
class InMemoryInboxRepository implements InboxRepository {
  InMemoryInboxRepository(this._signal, this._clock);

  final ChangeSignal _signal;
  final DateTime Function() _clock;
  final _items = <InboxItem>[];
  var _nextId = 0;

  void add(InboxType type, String who, {String? postId, DateTime? at}) {
    _items.insert(
      0,
      InboxItem(
        id: 'inbox-${_nextId++}',
        type: type,
        who: who,
        createdAt: at ?? _clock(),
        postId: postId,
      ),
    );
    _signal.notify();
  }

  @override
  Stream<List<InboxItem>> watchItems() {
    return _signal.watch(() => List.of(_items));
  }

  @override
  Future<void> clear() async {
    _items.clear();
    _signal.notify();
  }
}
