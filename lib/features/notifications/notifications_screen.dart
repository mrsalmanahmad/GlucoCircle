import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/divided_card.dart';
import '../../core/widgets/state_views.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/labels.dart';

/// No wireframe. The bell on Community opens this.
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final items = ref.watch(inboxProvider);
    final now = ref.read(clockProvider)();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                tooltip: l10n.actionBack,
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const AppIcon(AppIcons.back),
              ),
            ),
            const SizedBox(height: 8),
            Text(l10n.notificationsTitle, style: AppText.pageTitle),
            const SizedBox(height: 16),
            items.when(
              loading: () => const LoadingView(),
              error: (_, _) =>
                  ErrorView(onRetry: () => ref.invalidate(inboxProvider)),
              data: (list) => list.isEmpty
                  ? EmptyView(
                      title: l10n.inboxEmptyTitle,
                      body: l10n.inboxEmptyBody,
                    )
                  : DividedCard(
                      rows: [
                        for (final item in list)
                          _InboxRow(
                            text: switch (item.type) {
                              InboxType.reply => l10n.inboxReply(item.who),
                              InboxType.warmth => l10n.inboxWarmth(item.who),
                            },
                            time: l10n.timeAgo(item.createdAt, now),
                            onTap: () => context.push(
                              item.postId != null
                                  ? Routes.post(item.postId!)
                                  : Routes.fireflies,
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InboxRow extends StatelessWidget {
  const _InboxRow({
    required this.text,
    required this.time,
    required this.onTap,
  });

  final String text;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          spacing: 12,
          children: [
            Expanded(child: Text(text, style: AppText.bodySmall)),
            Text(
              time,
              style: AppText.small.copyWith(color: DayColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
