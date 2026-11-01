import 'package:flutter/material.dart';

import '../../core/theme/app_sizes.dart';
import '../../core/widgets/caution_text.dart';
import '../../core/widgets/coming_soon.dart';
import '../../core/widgets/page_header.dart';
import '../../l10n/generated/app_localizations.dart';

/// Screen 05, read-only. The content is Day 4 in docs/MVP_PLAN.md.
class HealthyScreen extends StatelessWidget {
  const HealthyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          children: [
            PageHeader(title: l10n.healthyTitle, subtitle: l10n.healthyIntro),
            const SizedBox(height: 16),
            const CautionText(),
            const SizedBox(height: 16),
            const ComingSoonText(),
          ],
        ),
      ),
    );
  }
}
