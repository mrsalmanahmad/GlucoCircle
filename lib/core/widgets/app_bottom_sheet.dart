import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';

/// Sheets are always Day styled, even when opened from Fireflies, because
/// they hold safety actions that must stay easy to read.
///
/// Pass no [title] if the child draws its own header with [SheetHeader].
Future<T?> showAppBottomSheet<T>(
  BuildContext context, {
  String? title,
  required Widget child,
}) {
  return showModalBottomSheet<T>(
    context: context,
    // Otherwise a sheet opened from a tab sits behind the bottom nav.
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    barrierColor: DayColors.scrim,
    backgroundColor: DayColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSizes.sheetRadius),
      ),
    ),
    builder: (_) => Theme(
      data: AppTheme.day,
      child: _SheetBody(title: title, child: child),
    ),
  );
}

class _SheetBody extends StatelessWidget {
  const _SheetBody({required this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSizes.screenPadding,
        12,
        AppSizes.screenPadding,
        32 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: DayColors.borderStrong,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            if (title != null) SheetHeader(title: title!),
            child,
          ],
        ),
      ),
    );
  }
}

class SheetHeader extends StatelessWidget {
  const SheetHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(title, style: AppText.sheetTitle),
          ),
        ),
        IconButton.filled(
          tooltip: AppLocalizations.of(context).actionClose,
          onPressed: () => Navigator.of(context).pop(),
          style: IconButton.styleFrom(
            backgroundColor: DayColors.background,
            foregroundColor: DayColors.ink,
          ),
          icon: const Icon(Icons.close, size: 22),
        ),
      ],
    );
  }
}
