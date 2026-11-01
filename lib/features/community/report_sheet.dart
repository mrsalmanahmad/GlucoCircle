import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/emergency.dart';
import '../../core/services/external_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_bottom_sheet.dart';
import '../../core/widgets/compact_button.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/labels.dart';

/// Screen 08, used for posts, replies, glows and warmth.
Future<void> showReportSheet(
  BuildContext context, {
  required ReportTarget target,
  required String id,
}) {
  return showAppBottomSheet<void>(
    context,
    child: _ReportBody(target: target, id: id),
  );
}

class _ReportBody extends ConsumerStatefulWidget {
  const _ReportBody({required this.target, required this.id});

  final ReportTarget target;
  final String id;

  @override
  ConsumerState<_ReportBody> createState() => _ReportBodyState();
}

class _ReportBodyState extends ConsumerState<_ReportBody> {
  var _reason = ReportReason.dangerousAdvice;
  var _sent = false;

  Future<void> _send() async {
    await ref
        .read(safetyRepositoryProvider)
        .report(widget.target, widget.id, _reason);
    if (mounted) setState(() => _sent = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_sent) return _sentView(l10n);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        SheetHeader(title: l10n.reportTitle(widget.target)),
        Text(
          l10n.reportPrivate,
          style: AppText.bodySmall.copyWith(color: DayColors.textMuted),
        ),
        Text(
          l10n.reportQuestion,
          style: AppText.bodySmall.copyWith(fontWeight: FontWeight.w700),
        ),
        RadioGroup<ReportReason>(
          groupValue: _reason,
          onChanged: (value) => setState(() => _reason = value!),
          child: Column(
            spacing: 8,
            children: [
              for (final reason in ReportReason.values)
                _ReasonTile(
                  reason: reason,
                  selected: reason == _reason,
                  onTap: () => setState(() => _reason = reason),
                ),
            ],
          ),
        ),
        PrimaryButton(
          label: l10n.reportSend,
          color: DayColors.danger,
          onPressed: _send,
        ),
      ],
    );
  }

  Future<void> _callEmergency(AppLocalizations l10n) async {
    final messenger = ScaffoldMessenger.of(context);
    final opened = await ref.read(externalLauncherProvider)(
      Uri(scheme: 'tel', path: emergencyNumber),
    );
    if (!opened) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.urgentCallFailed(emergencyNumber))),
      );
    }
  }

  Widget _sentView(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: DayColors.successBg,
              ),
              child: const Icon(
                Icons.check,
                size: 30,
                color: DayColors.successText,
              ),
            ),
          ),
          Text(
            l10n.reportSentTitle,
            textAlign: TextAlign.center,
            style: AppText.sheetTitle,
          ),
          Text(
            l10n.reportSentBody,
            textAlign: TextAlign.center,
            style: AppText.bodySmall.copyWith(color: DayColors.textMuted),
          ),
          if (_reason == ReportReason.danger) ...[
            Text(
              l10n.reportDangerSent(emergencyNumber),
              textAlign: TextAlign.center,
              style: AppText.bodySmall.copyWith(
                color: DayColors.dangerText,
                fontWeight: FontWeight.w600,
              ),
            ),
            CompactButton(
              label: l10n.urgentCall(emergencyNumber),
              color: DayColors.danger,
              onPressed: () => _callEmergency(l10n),
            ),
          ],
          const SizedBox(height: 8),
          PrimaryButton(
            label: l10n.actionDone,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _ReasonTile extends StatelessWidget {
  const _ReasonTile({
    required this.reason,
    required this.selected,
    required this.onTap,
  });

  final ReportReason reason;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      color: selected ? DayColors.selectedRow : DayColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          width: 2,
          color: selected ? DayColors.primary : DayColors.border,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 52),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Row(
              children: [
                Radio<ReportReason>(value: reason),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 1,
                    children: [
                      Text(
                        l10n.reportReasonTitle(reason),
                        style: AppText.rowTitle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        l10n.reportReasonNote(reason),
                        style: AppText.small.copyWith(
                          color: DayColors.textMuted,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
