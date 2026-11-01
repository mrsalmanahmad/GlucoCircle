import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/divided_card.dart';
import '../../core/widgets/state_views.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';

class BlockedPeopleScreen extends ConsumerWidget {
  const BlockedPeopleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final blocked = ref.watch(blockedProvider);
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
            Text(l10n.settingsBlocked, style: AppText.pageTitle),
            const SizedBox(height: 16),
            blocked.when(
              loading: () => const LoadingView(),
              error: (_, _) =>
                  ErrorView(onRetry: () => ref.invalidate(blockedProvider)),
              data: (people) => people.isEmpty
                  ? EmptyView(
                      title: l10n.blockedEmptyTitle,
                      body: l10n.blockedEmptyBody,
                    )
                  : DividedCard(
                      rows: [
                        for (final person in people)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    person.label ?? l10n.anonymousMember,
                                    style: AppText.bodySmall,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => ref
                                      .read(safetyRepositoryProvider)
                                      .unblock(person.personId),
                                  child: Text(l10n.unblockAction),
                                ),
                              ],
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
