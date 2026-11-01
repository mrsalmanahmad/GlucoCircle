import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_bottom_sheet.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/caution_text.dart';
import '../../core/widgets/coming_soon.dart';
import '../../core/widgets/divided_card.dart';
import '../../data/session_controller.dart';
import '../../l10n/generated/app_localizations.dart';

/// No wireframe. Both stores require delete account to be here.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _editNickname(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final session = ref.read(sessionProvider.notifier);
    final controller = TextEditingController(
      text: ref.read(sessionProvider)?.nickname,
    );
    final saved = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.consentNicknameLabel),
        content: AppTextField(controller: controller, maxLength: 20),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: Text(l10n.actionSave),
          ),
        ],
      ),
    );
    controller.dispose();
    if (saved != null && saved.isNotEmpty) session.updateNickname(saved);
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final session = ref.read(sessionProvider.notifier);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteAccountTitle),
        content: Text(l10n.deleteAccountBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: DayColors.danger),
            child: Text(l10n.deleteAccountConfirm),
          ),
        ],
      ),
    );
    if (confirmed == true) await session.deleteAccount();
  }

  void _openPending(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ComingSoonScreen(title: title)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionProvider);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                tooltip: l10n.actionBack,
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const AppIcon(AppIcons.back),
              ),
            ),
            const SizedBox(height: 8),
            Text(l10n.settingsTitle, style: AppText.pageTitle),
            const SizedBox(height: 16),
            DividedCard(
              rows: [
                _SettingsRow(
                  label: l10n.consentNicknameLabel,
                  value: session?.nickname,
                  onTap: () => _editNickname(context, ref),
                ),
                _SettingsRow(
                  label: l10n.settingsTopics,
                  onTap: () => context.push(Routes.editTopics),
                ),
                _SettingsRow(
                  label: l10n.settingsBlocked,
                  onTap: () => context.push(Routes.blockedPeople),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DividedCard(
              rows: [
                _SettingsRow(
                  label: l10n.rulesTitle,
                  onTap: () => showAppBottomSheet<void>(
                    context,
                    title: l10n.rulesTitle,
                    child: Text(l10n.rulesBody, style: AppText.body),
                  ),
                ),
                _SettingsRow(
                  label: l10n.settingsPrivacy,
                  onTap: () => _openPending(context, l10n.settingsPrivacy),
                ),
                _SettingsRow(
                  label: l10n.settingsTerms,
                  onTap: () => _openPending(context, l10n.settingsTerms),
                ),
                _SettingsRow(
                  label: l10n.settingsContact,
                  onTap: () => _openPending(context, l10n.settingsContact),
                ),
                _SettingsRow(
                  label: l10n.settingsLicences,
                  onTap: () => showLicensePage(
                    context: context,
                    applicationName: l10n.appTitle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DividedCard(
              rows: [
                _SettingsRow(
                  label: l10n.settingsSignOut,
                  onTap: ref.read(sessionProvider.notifier).signOut,
                ),
                _SettingsRow(
                  label: l10n.deleteAccountTitle,
                  colour: DayColors.danger,
                  onTap: () => _confirmDelete(context, ref),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const CautionText(),
          ],
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.label,
    required this.onTap,
    this.value,
    this.colour,
  });

  final String label;
  final String? value;
  final Color? colour;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 52),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppText.bodySmall.copyWith(
                    color: colour,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (value != null)
                Text(
                  value!,
                  style: AppText.bodySmall.copyWith(color: DayColors.textMuted),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
