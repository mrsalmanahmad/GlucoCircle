import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/coming_soon.dart';
import '../features/community/community_screen.dart';
import '../features/community/share_screen.dart';
import '../features/fireflies/fireflies_screen.dart';
import '../features/healthy/healthy_screen.dart';
import '../features/signs/signs_screen.dart';
import '../l10n/generated/app_localizations.dart';
import 'app_shell.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: Routes.community,
    routes: [
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
        path: Routes.fireflies,
        builder: (context, state) => const FirefliesScreen(),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) =>
            ComingSoonScreen(title: AppLocalizations.of(context).settingsTitle),
      ),
      GoRoute(
        path: Routes.notifications,
        builder: (context, state) => ComingSoonScreen(
          title: AppLocalizations.of(context).notificationsTitle,
        ),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
