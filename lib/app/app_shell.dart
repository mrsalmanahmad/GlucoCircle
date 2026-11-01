import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_sizes.dart';
import '../core/theme/app_text.dart';
import '../core/widgets/app_icon.dart';
import '../l10n/generated/app_localizations.dart';
import 'routes.dart';

/// The bottom tabs: Community, Share, Signs, Healthy.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _openBranch(int branch) {
    // Tapping the current tab goes back to the top of that tab.
    shell.goBranch(branch, initialLocation: branch == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = shell.currentIndex;
    return Scaffold(
      body: shell,
      bottomNavigationBar: _BottomNav(
        items: [
          _NavItem(
            icon: AppIcons.community,
            label: l10n.tabCommunity,
            selected: current == 0,
            onTap: () => _openBranch(0),
          ),
          _NavItem(
            icon: AppIcons.share,
            label: l10n.tabShare,
            selected: false,
            onTap: () => context.push(Routes.share),
          ),
          _NavItem(
            icon: AppIcons.signs,
            label: l10n.tabSigns,
            selected: current == 1,
            onTap: () => _openBranch(1),
          ),
          _NavItem(
            icon: AppIcons.healthy,
            label: l10n.tabHealthy,
            selected: current == 2,
            onTap: () => _openBranch(2),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.items});

  final List<_NavItem> items;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Container(
      decoration: const BoxDecoration(
        color: DayColors.surface,
        border: Border(top: BorderSide(color: DayColors.border)),
      ),
      padding: EdgeInsets.fromLTRB(
        6,
        0,
        6,
        math.max(bottomInset, AppSizes.navBottomPadding),
      ),
      // Labels may grow with system text size, but not past what the bar fits.
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1.3,
        child: Row(children: [for (final item in items) Expanded(child: item)]),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final AppIcons icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? DayColors.primary : DayColors.textFaint;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        // The whole height of the bar is tappable, not just the icon and label.
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSizes.navHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              AppIcon(icon, color: color),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.navLabel.copyWith(
                  color: color,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
