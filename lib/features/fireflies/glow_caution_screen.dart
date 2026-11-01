import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/config/emergency.dart';
import '../../core/services/external_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/compact_button.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import 'light_glow_screen.dart';

/// Replaces screen 11. It takes no blood sugar number and gives no treatment
/// steps, because the app must never judge a reading. See issue S2 in
/// docs/wireframes/README.md.
class GlowCautionScreen extends ConsumerWidget {
  const GlowCautionScreen({super.key, required this.feeling});

  final GlowFeeling feeling;

  Future<void> _call(BuildContext context, WidgetRef ref) async {
    final message = AppLocalizations.of(context)
        .urgentCallFailed(emergencyNumber);
    final messenger = ScaffoldMessenger.of(context);
    final opened = await ref.read(externalLauncherProvider)(
      Uri(scheme: 'tel', path: emergencyNumber),
    );
    if (!opened) messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _continue(BuildContext context, WidgetRef ref) async {
    final router = GoRouter.of(context);
    final navigator = Navigator.of(context);
    final pending = ref.read(pendingGlowProvider)!;
    final outcome = await ref
        .read(firefliesRepositoryProvider)
        .lightGlow(
          feeling: feeling,
          line: pending.line,
          duration: pending.duration,
        );
    if (outcome == PublishOutcome.heldForReview) {
      // Back to the form, which shows why the line needs rewording.
      navigator.pop(true);
    } else {
      navigator.pop(false);
      router.pushReplacement(Routes.quietGlow);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return NightMood(
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.screenPadding,
                8,
                AppSizes.screenPadding,
                24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 32,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 16,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Transform.translate(
                          offset: const Offset(-10, 0),
                          child: IconButton(
                            tooltip: l10n.actionBack,
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const AppIcon(AppIcons.back),
                          ),
                        ),
                      ),
                      Text(l10n.cautionTitle, style: AppText.nightHeading),
                      Text(
                        l10n.cautionBody,
                        style: AppText.body.copyWith(color: NightColors.sub),
                      ),
                      CompactButton(
                        label: l10n.urgentCall(emergencyNumber),
                        color: DayColors.danger,
                        onPressed: () => _call(context, ref),
                      ),
                      const Spacer(),
                      PrimaryButton(
                        label: l10n.cautionContinue,
                        onPressed: () => _continue(context, ref),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
