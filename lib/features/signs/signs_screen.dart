import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/emergency.dart';
import '../../core/services/external_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/caution_text.dart';
import '../../core/widgets/compact_button.dart';
import '../../core/widgets/divided_card.dart';
import '../../core/widgets/page_header.dart';
import '../../l10n/generated/app_localizations.dart';

/// Screen 04, reworked to be read-only. It must never take a person's symptoms
/// and give an answer back. See product rule 2 in docs/MVP_PLAN.md.
class SignsScreen extends ConsumerWidget {
  const SignsScreen({super.key});

  Future<void> _open(
    BuildContext context,
    WidgetRef ref,
    Uri uri,
    String failureMessage,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final opened = await ref.read(externalLauncherProvider)(uri);
    if (!opened) {
      messenger.showSnackBar(SnackBar(content: Text(failureMessage)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.screenPadding,
            AppSizes.screenPadding,
            AppSizes.screenPadding,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 20,
            children: [
              PageHeader(title: l10n.signsTitle, subtitle: l10n.signsIntro),
              const CautionText(),
              DividedCard(
                rows: [
                  _SignRow(l10n.signThirstyTitle, l10n.signThirstyNote),
                  _SignRow(l10n.signUrinatingTitle, l10n.signUrinatingNote),
                  _SignRow(l10n.signTiredTitle, l10n.signTiredNote),
                  _SignRow(l10n.signWeightTitle, l10n.signWeightNote),
                  _SignRow(l10n.signHungryTitle, l10n.signHungryNote),
                  _SignRow(l10n.signVisionTitle, l10n.signVisionNote),
                  _SignRow(l10n.signCutsTitle, l10n.signCutsNote),
                  _SignRow(l10n.signTinglingTitle, l10n.signTinglingNote),
                ],
              ),
              _ConsultCard(
                onFindTest: () => _open(
                  context,
                  ref,
                  Uri.https('www.google.com', '/maps/search/', {
                    'api': '1',
                    'query': l10n.signsFindTestQuery,
                  }),
                  l10n.signsFindTestFailed,
                ),
              ),
              const _NumbersSection(),
              _UrgentCard(
                onCall: () => _open(
                  context,
                  ref,
                  Uri(scheme: 'tel', path: emergencyNumber),
                  l10n.urgentCallFailed(emergencyNumber),
                ),
              ),
              Text(
                l10n.sourceAda,
                style: AppText.small.copyWith(color: DayColors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignRow extends StatelessWidget {
  const _SignRow(this.title, this.note);

  final String title;
  final String note;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 1,
          children: [
            Text(
              title,
              style: AppText.rowTitle.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              note,
              style: AppText.small.copyWith(
                color: DayColors.textMuted,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsultCard extends StatelessWidget {
  const _ConsultCard({required this.onFindTest});

  final VoidCallback onFindTest;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _ColouredCard(
      color: DayColors.warnBg,
      children: [
        Text(l10n.signsConsult, style: AppText.body),
        const SizedBox(height: 4),
        CompactButton(
          label: l10n.signsFindTest,
          color: DayColors.primary,
          onPressed: onFindTest,
        ),
      ],
    );
  }
}

class _UrgentCard extends StatelessWidget {
  const _UrgentCard({required this.onCall});

  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _ColouredCard(
      color: DayColors.dangerBg,
      children: [
        Row(
          spacing: 8,
          children: [
            const AppIcon(
              AppIcons.warning,
              size: 20,
              color: DayColors.dangerText,
            ),
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  l10n.urgentTitle,
                  style: AppText.cardTitle.copyWith(
                    color: DayColors.dangerText,
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          l10n.urgentBody,
          style: AppText.bodySmall.copyWith(color: DayColors.dangerBody),
        ),
        CompactButton(
          label: l10n.urgentCall(emergencyNumber),
          color: DayColors.danger,
          onPressed: onCall,
        ),
      ],
    );
  }
}

class _ColouredCard extends StatelessWidget {
  const _ColouredCard({required this.color, required this.children});

  final Color color;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: children,
      ),
    );
  }
}

class _NumbersSection extends StatelessWidget {
  const _NumbersSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: [
        Semantics(
          header: true,
          child: Text(l10n.numbersTitle, style: AppText.sectionTitle),
        ),
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Table(
            columnWidths: const {0: FlexColumnWidth(1.3)},
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  _HeaderCell(l10n.numbersTest, DayColors.textMuted),
                  _HeaderCell(l10n.numbersNormal, DayColors.successText),
                  _HeaderCell(l10n.numbersPre, DayColors.warnText),
                  _HeaderCell(l10n.numbersDiabetes, DayColors.danger),
                ],
              ),
              _row(
                l10n.numbersFasting,
                l10n.numbersFastingUnit,
                l10n.numbersFastingNormal,
                l10n.numbersFastingPre,
                l10n.numbersFastingDiabetes,
              ),
              _row(
                l10n.numbersA1c,
                l10n.numbersA1cUnit,
                l10n.numbersA1cNormal,
                l10n.numbersA1cPre,
                l10n.numbersA1cDiabetes,
              ),
            ],
          ),
        ),
      ],
    );
  }

  TableRow _row(
    String test,
    String unit,
    String normal,
    String pre,
    String diabetes,
  ) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: DayColors.divider)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text.rich(
            TextSpan(
              style: AppText.chip,
              children: [
                TextSpan(text: '$test\n'),
                TextSpan(
                  text: unit,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: DayColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
        _ValueCell(normal),
        _ValueCell(pre),
        _ValueCell(diabetes),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text, this.color);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: AppText.chip.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _ValueCell extends StatelessWidget {
  const _ValueCell(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppText.chip.copyWith(fontWeight: FontWeight.w400),
    );
  }
}
