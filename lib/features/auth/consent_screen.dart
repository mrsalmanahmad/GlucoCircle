import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/session_controller.dart';
import '../../l10n/generated/app_localizations.dart';

/// No wireframe. The 18+ check, the medical caution and the community rules.
class ConsentScreen extends ConsumerStatefulWidget {
  const ConsentScreen({super.key});

  @override
  ConsumerState<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends ConsumerState<ConsentScreen> {
  static const _maxNickname = 20;

  final _nickname = TextEditingController();
  var _isAdult = false;
  var _understands = false;

  @override
  void dispose() {
    _nickname.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _nickname.text.trim().isNotEmpty && _isAdult && _understands;

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
            spacing: 16,
            children: [
              const AppLogo(),
              Text(
                l10n.consentTitle,
                style: AppText.pageTitle.copyWith(fontSize: 28, height: 1.2),
              ),
              AppTextField(
                controller: _nickname,
                label: l10n.consentNicknameLabel,
                hint: l10n.consentNicknameHint,
                maxLength: _maxNickname,
                onChanged: (_) => setState(() {}),
              ),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    Text(l10n.rulesTitle, style: AppText.cardTitle),
                    Text(l10n.rulesBody, style: AppText.bodySmall),
                  ],
                ),
              ),
              CheckboxListTile(
                value: _isAdult,
                onChanged: (value) => setState(() => _isAdult = value!),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(l10n.consentAdult, style: AppText.bodySmall),
              ),
              CheckboxListTile(
                value: _understands,
                onChanged: (value) => setState(() => _understands = value!),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(l10n.consentCaution, style: AppText.bodySmall),
              ),
              PrimaryButton(
                label: l10n.actionContinue,
                onPressed: _canContinue
                    ? () => ref
                          .read(sessionProvider.notifier)
                          .completeConsent(_nickname.text.trim())
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
