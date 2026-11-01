import 'package:flutter/material.dart';

import '../../core/theme/app_palette.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/coming_soon.dart';
import '../../core/widgets/firefly_glow.dart';
import '../../l10n/generated/app_localizations.dart';

/// Screen 09. The sky is Day 10 in docs/MVP_PLAN.md.
class FirefliesScreen extends StatelessWidget {
  const FirefliesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NightMood(child: _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              IconButton(
                tooltip: l10n.actionBack,
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const AppIcon(AppIcons.back),
              ),
              Text(l10n.firefliesTitle, style: AppText.nightTitle),
              Text(
                l10n.firefliesIntro,
                style: AppText.body.copyWith(
                  color: context.palette.textSecondary,
                ),
              ),
              const SizedBox(height: 48),
              const Center(child: FireflyGlow(size: 20)),
              const SizedBox(height: 48),
              const ComingSoonText(),
            ],
          ),
        ),
      ),
    );
  }
}
