import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_palette.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text.dart';

Future<T?> showAppBottomSheet<T>(
  BuildContext context, {
  required String title,
  required Widget child,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    barrierColor: DayColors.scrim,
    backgroundColor: context.palette.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSizes.sheetRadius),
      ),
    ),
    builder: (_) => _SheetBody(title: title, child: child),
  );
}

class _SheetBody extends StatelessWidget {
  const _SheetBody({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
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
            Row(
              children: [
                Expanded(child: Text(title, style: AppText.sheetTitle)),
                IconButton.filled(
                  tooltip: AppLocalizations.of(context).actionClose,
                  onPressed: () => Navigator.of(context).pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: palette.background,
                    foregroundColor: palette.textPrimary,
                  ),
                  icon: const Icon(Icons.close, size: 22),
                ),
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }
}
