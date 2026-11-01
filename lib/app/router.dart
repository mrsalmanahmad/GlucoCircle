import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/models.dart';
import '../data/session_controller.dart';
import '../features/auth/consent_screen.dart';
import '../features/auth/email_sign_in_screen.dart';
import '../features/auth/welcome_screen.dart';
import '../features/community/community_screen.dart';
import '../features/community/post_detail_screen.dart';
import '../features/community/share_screen.dart';
import '../features/fireflies/fireflies_screen.dart';
import '../features/fireflies/glow_caution_screen.dart';
import '../features/fireflies/light_glow_screen.dart';
import '../features/fireflies/quiet_glow_screen.dart';
import '../features/healthy/healthy_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/settings/blocked_people_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/signs/signs_screen.dart';
import 'app_shell.dart';
import 'routes.dart';

/// Where someone has to be, given how far through setup they are. Null means
/// they can stay where they asked to go.
@visibleForTesting
String? setupRedirect(Session? session, String location) {
  if (session == null) {
    return location.startsWith(Routes.welcome) ? null : Routes.welcome;
  }
  if (!session.consented) {
    return location == Routes.consent ? null : Routes.consent;
  }
  if (!session.onboarded) {
    return location == Routes.onboarding ? null : Routes.onboarding;
  }
  final inSetup =
      location.startsWith(Routes.welcome) ||
      location == Routes.consent ||
      location == Routes.onboarding;
  return inSetup ? Routes.community : null;
}

final routerProvider = Provider<GoRouter>((ref) {
  final sessionChanged = ValueNotifier<int>(0);
  ref.listen(sessionProvider, (_, _) => sessionChanged.value++);

  final router = GoRouter(
    initialLocation: Routes.community,
    refreshListenable: sessionChanged,
    redirect: (context, state) =>
        setupRedirect(ref.read(sessionProvider), state.matchedLocation),
    routes: [
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomeScreen(),
        routes: [
          GoRoute(
            path: 'email',
            builder: (context, state) => const EmailSignInScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.consent,
        builder: (context, state) => const ConsentScreen(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      // Share is a tab in the nav, but opens full screen with no nav (screen
      // 03), so it isn't a branch here. AppShell pushes it.
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.community,
                builder: (context, state) => const CommunityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.signs,
                builder: (context, state) => const SignsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.healthy,
                builder: (context, state) => const HealthyScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.share,
        builder: (context, state) => const ShareScreen(),
      ),
      GoRoute(
        path: '/post/:id',
        builder: (context, state) =>
            PostDetailScreen(postId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.fireflies,
        builder: (context, state) => const FirefliesScreen(),
        routes: [
          GoRoute(
            path: 'glow',
            builder: (context, state) => const LightGlowScreen(),
          ),
          GoRoute(
            path: 'caution',
            builder: (context, state) =>
                GlowCautionScreen(feeling: state.extra! as GlowFeeling),
          ),
          GoRoute(
            path: 'quiet',
            builder: (context, state) => const QuietGlowScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'topics',
            builder: (context, state) => const OnboardingScreen(editing: true),
          ),
          GoRoute(
            path: 'blocked',
            builder: (context, state) => const BlockedPeopleScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    sessionChanged.dispose();
  });
  return router;
});
