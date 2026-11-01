import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/models.dart';
import '../../data/session_controller.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/labels.dart';

/// Screen 06, reworked. It asks for topics, not diagnoses, and can be skipped.
/// [editing] reuses it from Settings.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key, this.editing = false});

  final bool editing;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final Set<Interest> _picked = {...?ref.read(sessionProvider)?.interests};

  void _finish(Set<Interest> interests) {
    final session = ref.read(sessionProvider.notifier);
    if (widget.editing) {
      session.updateInterests(interests);
      Navigator.of(context).pop();
    } else {
      session.completeOnboarding(interests);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: DayColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  if (widget.editing)
                    IconButton(
                      tooltip: l10n.actionBack,
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const AppIcon(AppIcons.back),
                    )
                  else ...[
                    const AppLogo(),
                    const Spacer(),
                    TextButton(
                      onPressed: () => _finish(const {}),
                      child: Text(l10n.actionSkip),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 22),
              Text(
                l10n.onboardingTitle,
                style: AppText.pageTitle.copyWith(fontSize: 28, height: 1.2),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.onboardingBody,
                style: AppText.body.copyWith(color: DayColors.textMuted),
              ),
              const SizedBox(height: 22),
              for (final interest in Interest.values) ...[
                _InterestTile(
                  title: l10n.interestTitle(interest),
                  note: l10n.interestNote(interest),
                  selected: _picked.contains(interest),
                  onTap: () => setState(() {
                    if (!_picked.remove(interest)) _picked.add(interest);
                  }),
                ),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 12),
              PrimaryButton(
                label: l10n.actionContinue,
                onPressed: () => _finish(_picked),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InterestTile extends StatelessWidget {
  const _InterestTile({
    required this.title,
    required this.note,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String note;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? DayColors.selectedRow : DayColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            width: 2,
            color: selected ? DayColors.primary : DayColors.border,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(title, style: AppText.rowTitle),
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
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected ? DayColors.primary : DayColors.surface,
                      border: Border.all(
                        width: 2,
                        color: selected ? DayColors.primary : DayColors.control,
                      ),
                    ),
                    child: selected
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
