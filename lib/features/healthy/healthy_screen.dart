import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/caution_text.dart';
import '../../core/widgets/divided_card.dart';
import '../../core/widgets/page_header.dart';
import '../../l10n/generated/app_localizations.dart';

/// Screen 05, reworked to be read-only: no goal tracking and no reminders.
/// See product rule 1 in docs/MVP_PLAN.md.
class HealthyScreen extends StatelessWidget {
  const HealthyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              PageHeader(title: l10n.healthyTitle, subtitle: l10n.healthyIntro),
              const CautionText(),
              const _PlateCard(),
              const _RiskSection(),
              const _GetCheckedCard(),
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

class _PlateCard extends StatelessWidget {
  const _PlateCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Semantics(
            header: true,
            child: Text(l10n.plateTitle, style: AppText.cardTitle),
          ),
          Row(
            spacing: 18,
            children: [
              Semantics(
                image: true,
                label: l10n.plateSemantics,
                child: const _Plate(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    _PlateLegend(
                      color: DayColors.plateVegetables,
                      share: '½',
                      label: l10n.plateVegetables,
                    ),
                    _PlateLegend(
                      color: DayColors.plateProtein,
                      share: '¼',
                      label: l10n.plateProtein,
                    ),
                    _PlateLegend(
                      color: DayColors.plateGrains,
                      share: '¼',
                      label: l10n.plateGrains,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            l10n.plateWater,
            style: AppText.chip.copyWith(
              color: DayColors.textMuted,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _Plate extends StatelessWidget {
  const _Plate();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: DayColors.plateRing,
      ),
      child: const DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Half, then a quarter, then a quarter, clockwise from the top.
          gradient: SweepGradient(
            transform: GradientRotation(-math.pi / 2),
            colors: [
              DayColors.plateVegetables,
              DayColors.plateVegetables,
              DayColors.plateProtein,
              DayColors.plateProtein,
              DayColors.plateGrains,
              DayColors.plateGrains,
            ],
            stops: [0, 0.5, 0.5, 0.75, 0.75, 1],
          ),
        ),
      ),
    );
  }
}

class _PlateLegend extends StatelessWidget {
  const _PlateLegend({
    required this.color,
    required this.share,
    required this.label,
  });

  final Color color;
  final String share;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: AppText.bodySmall,
              children: [
                TextSpan(
                  text: '$share ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: label),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RiskSection extends StatelessWidget {
  const _RiskSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: [
        Semantics(
          header: true,
          child: Text(l10n.riskTitle, style: AppText.sectionTitle),
        ),
        DividedCard(
          rows: [
            _RiskRow(l10n.riskAge),
            _RiskRow(l10n.riskFamily),
            _RiskRow(l10n.riskWeight),
            _RiskRow(l10n.riskActivity),
            _RiskRow(l10n.riskPregnancy),
            _RiskRow(l10n.riskSouthAsian),
          ],
        ),
      ],
    );
  }
}

class _RiskRow extends StatelessWidget {
  const _RiskRow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(text, style: AppText.bodySmall),
    );
  }
}

class _GetCheckedCard extends StatelessWidget {
  const _GetCheckedCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: DayColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Semantics(
            header: true,
            child: Text(
              l10n.checkedTitle,
              style: AppText.cardTitle.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          Text(
            l10n.checkedBody,
            style: AppText.bodySmall.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
