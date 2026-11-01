import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/caution_text.dart';
import '../../core/widgets/coming_soon.dart';
import '../../core/widgets/page_header.dart';
import '../../core/widgets/round_icon_button.dart';
import '../../l10n/generated/app_localizations.dart';

/// Screen 02. The feed itself is Day 6 in docs/MVP_PLAN.md.
class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      floatingActionButton: _ShareStoryButton(
        label: l10n.communityShareStory,
        onPressed: () => context.push(Routes.share),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          children: [
            PageHeader(
              title: l10n.communityTitle,
              subtitle: l10n.communitySubtitle,
              actions: [
                RoundIconButton(
                  icon: AppIcons.settings,
                  label: l10n.settingsTitle,
                  onPressed: () => context.push(Routes.settings),
                ),
                RoundIconButton(
                  icon: AppIcons.bell,
                  label: l10n.notificationsTitle,
                  onPressed: () => context.push(Routes.notifications),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _FirefliesBanner(onTap: () => context.push(Routes.fireflies)),
            const SizedBox(height: 16),
            const CautionText(),
            const SizedBox(height: 16),
            const ComingSoonText(),
          ],
        ),
      ),
    );
  }
}

class _FirefliesBanner extends StatelessWidget {
  const _FirefliesBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      color: NightColors.background,
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            spacing: 14,
            children: [
              const _BannerSky(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      l10n.firefliesBannerTitle,
                      style: AppText.rowTitle.copyWith(
                        color: NightColors.cream,
                      ),
                    ),
                    Text(
                      l10n.firefliesBannerBody,
                      style: AppText.chip.copyWith(
                        color: NightColors.sub,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const AppIcon(
                AppIcons.chevronRight,
                size: 20,
                color: NightColors.glow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerSky extends StatelessWidget {
  const _BannerSky();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.minTapTarget,
      height: AppSizes.minTapTarget,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: NightColors.surface,
      ),
      child: const Stack(
        children: [
          Positioned(left: 10, top: 12, child: _Dot(size: 8)),
          Positioned(left: 26, top: 20, child: _Dot(size: 6)),
          Positioned(left: 16, top: 28, child: _Dot(size: 5)),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: NightColors.glow,
        boxShadow: [
          BoxShadow(color: Color(0x8CFFC857), blurRadius: 8, spreadRadius: 3),
        ],
      ),
    );
  }
}

class _ShareStoryButton extends StatelessWidget {
  const _ShareStoryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.floatingButtonHeight / 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D1E4FD8),
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: FilledButton.icon(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: palette.accent,
          foregroundColor: palette.onAccent,
          minimumSize: const Size(0, AppSizes.floatingButtonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          textStyle: AppText.rowTitle,
        ),
        icon: const Icon(Icons.add, size: 20),
        label: Text(label),
      ),
    );
  }
}
