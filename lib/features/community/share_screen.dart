import 'package:flutter/material.dart';

import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/coming_soon.dart';
import '../../l10n/generated/app_localizations.dart';

/// Screen 03. The composer is Day 7 in docs/MVP_PLAN.md.
class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: Text(l10n.actionCancel),
              ),
              Text(l10n.shareTitle, style: AppText.sheetTitle),
              const ComingSoonText(),
            ],
          ),
        ),
      ),
    );
  }
}
