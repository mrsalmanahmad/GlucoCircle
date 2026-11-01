import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_bottom_sheet.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import 'report_sheet.dart';

/// The `...` button: report and block on other people's content, delete on
/// your own. Apple guideline 1.2 needs both report and block.
class ContentActionsButton extends ConsumerWidget {
  const ContentActionsButton({
    super.key,
    required this.target,
    required this.id,
    required this.isMine,
    this.onDelete,
    this.onBlocked,
    this.color,
  });

  final ReportTarget target;
  final String id;
  final bool isMine;
  final Future<void> Function()? onDelete;
  final VoidCallback? onBlocked;
  final Color? color;

  Future<void> _confirmBlock(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.blockConfirmTitle),
        content: Text(l10n.blockConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.blockAction),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(safetyRepositoryProvider).blockAuthor(target, id);
    onBlocked?.call();
  }

  void _open(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    showAppBottomSheet<void>(
      context,
      title: l10n.actionsTitle,
      child: Builder(
        builder: (sheetContext) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isMine && onDelete != null)
              _ActionRow(
                label: l10n.actionDelete,
                color: DayColors.danger,
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  onDelete!();
                },
              ),
            if (!isMine) ...[
              _ActionRow(
                label: l10n.actionReport,
                color: DayColors.danger,
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  showReportSheet(context, target: target, id: id);
                },
              ),
              _ActionRow(
                label: l10n.blockAction,
                color: DayColors.ink,
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _confirmBlock(context, ref);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: AppLocalizations.of(context).actionsTitle,
      constraints: const BoxConstraints.tightFor(width: 44, height: 44),
      padding: EdgeInsets.zero,
      onPressed: () => _open(context, ref),
      icon: AppIcon(AppIcons.more, color: color ?? DayColors.textMuted),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 52),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(label, style: AppText.rowTitle.copyWith(color: color)),
        ),
      ),
    );
  }
}
