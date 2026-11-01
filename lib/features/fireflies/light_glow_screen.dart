import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_chip.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/firefly_glow.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/labels.dart';

/// Holds what someone chose while they're on the caution step.
final pendingGlowProvider =
    NotifierProvider<PendingGlowController, PendingGlow?>(
      PendingGlowController.new,
    );

typedef PendingGlow = ({String line, GlowDuration duration});

class PendingGlowController extends Notifier<PendingGlow?> {
  @override
  PendingGlow? build() => null;

  void set(PendingGlow glow) => state = glow;
}

/// Screen 10, Lite: feeling, one line and duration. No chat modes or matching.
class LightGlowScreen extends StatelessWidget {
  const LightGlowScreen({super.key});

  @override
  Widget build(BuildContext context) => const NightMood(child: _Body());
}

class _Body extends ConsumerStatefulWidget {
  const _Body();

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  final _line = TextEditingController();
  GlowFeeling? _feeling;
  var _duration = GlowDuration.min30;
  var _held = false;

  @override
  void dispose() {
    _line.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    final feeling = _feeling!;
    final line = _line.text.trim();
    if (feeling.needsCaution) {
      ref.read(pendingGlowProvider.notifier).set((
        line: line,
        duration: _duration,
      ));
      final held = await context.push<bool>(Routes.glowCaution, extra: feeling);
      if (held == true && mounted) setState(() => _held = true);
      return;
    }
    final outcome = await ref
        .read(firefliesRepositoryProvider)
        .lightGlow(feeling: feeling, line: line, duration: _duration);
    if (!mounted) return;
    if (outcome == PublishOutcome.heldForReview) {
      setState(() => _held = true);
    } else {
      context.pushReplacement(Routes.quietGlow);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.screenPadding,
            8,
            AppSizes.screenPadding,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 22,
            children: [
              Row(
                children: [
                  Transform.translate(
                    offset: const Offset(-8, 0),
                    child: TextButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      style: TextButton.styleFrom(
                        foregroundColor: NightColors.sub,
                        textStyle: AppText.rowTitle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text(l10n.actionCancel),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 4,
                    child: Text(
                      l10n.glowPrivacy,
                      textAlign: TextAlign.end,
                      style: AppText.chip.copyWith(color: NightColors.muted),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 16,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: NightColors.border),
                    ),
                    child: const FireflyGlow(size: 20),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(l10n.glowTitle, style: AppText.nightHeading),
                        Text(
                          l10n.glowSubtitle,
                          style: AppText.bodySmall.copyWith(
                            color: NightColors.sub,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 2,
                children: [
                  Text(l10n.glowQuestion, style: AppText.rowTitle),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final feeling in GlowFeeling.values)
                        AppChip(
                          label: l10n.glowFeelingLabel(feeling),
                          selected: _feeling == feeling,
                          onTap: () => setState(() => _feeling = feeling),
                        ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  Text(l10n.glowLineLabel, style: AppText.rowTitle),
                  AppTextField(
                    controller: _line,
                    hint: l10n.glowLineHint,
                    hintStyle: AppText.quote.copyWith(
                      color: NightColors.hint,
                      fontSize: 17,
                    ),
                    style: AppText.quote.copyWith(
                      color: NightColors.cream,
                      fontSize: 17,
                    ),
                    maxLines: 3,
                    minLines: 2,
                    maxLength: 140,
                    errorText: _held ? l10n.glowHeld : null,
                    onChanged: (_) {
                      if (_held) setState(() => _held = false);
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 2,
                children: [
                  Text(l10n.glowDurationLabel_, style: AppText.rowTitle),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final duration in GlowDuration.values)
                        AppChip(
                          label: l10n.glowDurationLabel(duration),
                          selected: _duration == duration,
                          onTap: () => setState(() => _duration = duration),
                        ),
                    ],
                  ),
                ],
              ),
              Text(
                l10n.glowFootnote,
                style: AppText.small.copyWith(color: NightColors.muted),
              ),
              PrimaryButton(
                label: l10n.glowStart,
                onPressed: _feeling == null ? null : _start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
