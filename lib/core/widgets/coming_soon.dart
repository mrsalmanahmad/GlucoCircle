import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_palette.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text.dart';
import 'app_icon.dart';

/// Stand-in for a screen that has a route but isn't built yet.
class ComingSoonText extends StatelessWidget {
  const ComingSoonText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).comingSoon,
      style: AppText.body.copyWith(color: context.palette.textSecondary),
    );
  }
}

/// A full screen with a back button, for routes outside the tabs.
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              IconButton(
                tooltip: AppLocalizations.of(context).actionBack,
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const AppIcon(AppIcons.back),
              ),
              Text(title, style: AppText.pageTitle),
              const ComingSoonText(),
            ],
          ),
        ),
      ),
    );
  }
}
