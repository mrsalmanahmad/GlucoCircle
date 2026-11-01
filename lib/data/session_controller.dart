import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models.dart';
import 'providers.dart';

/// Who is signed in when the app starts. Tests override this.
final initialSessionProvider = Provider<Session?>((ref) => null);

final sessionProvider = NotifierProvider<SessionController, Session?>(
  SessionController.new,
);

/// TEMPORARY: sign-in accepts anything until Firebase Auth is connected, so
/// a build with this code must not go to the stores.
class SessionController extends Notifier<Session?> {
  static const _temporaryUserId = 'me';

  @override
  Session? build() => ref.watch(initialSessionProvider);

  void signIn() => state = const Session(userId: _temporaryUserId);

  void completeConsent(String nickname) {
    state = state?.copyWith(nickname: nickname, consented: true);
  }

  void completeOnboarding(Set<Interest> interests) {
    state = state?.copyWith(onboarded: true, interests: interests);
  }

  void updateNickname(String nickname) {
    state = state?.copyWith(nickname: nickname);
  }

  void updateInterests(Set<Interest> interests) {
    state = state?.copyWith(interests: interests);
  }

  void signOut() => state = null;

  Future<void> deleteAccount() async {
    await ref.read(forgetCurrentPersonProvider)();
    state = null;
  }
}
