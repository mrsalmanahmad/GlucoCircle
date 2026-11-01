import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_palette.dart';
import '../theme/app_text.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Text(
            l10n.errorTitle,
            textAlign: TextAlign.center,
            style: AppText.cardTitle,
          ),
          Text(
            l10n.errorBody,
            textAlign: TextAlign.center,
            style: AppText.bodySmall.copyWith(
              color: context.palette.textSecondary,
            ),
          ),
          TextButton(onPressed: onRetry, child: Text(l10n.actionTryAgain)),
        ],
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Text(title, textAlign: TextAlign.center, style: AppText.cardTitle),
          Text(
            body,
            textAlign: TextAlign.center,
            style: AppText.bodySmall.copyWith(
              color: context.palette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
