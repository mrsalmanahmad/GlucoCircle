import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/session_controller.dart';
import '../../l10n/generated/app_localizations.dart';

/// No wireframe. Forgot-password arrives with Firebase Auth.
class EmailSignInScreen extends ConsumerStatefulWidget {
  const EmailSignInScreen({super.key});

  @override
  ConsumerState<EmailSignInScreen> createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends ConsumerState<EmailSignInScreen> {
  static const _minPasswordLength = 8;

  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    final l10n = AppLocalizations.of(context);
    final emailOk = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(_email.text.trim());
    final passwordOk = _password.text.length >= _minPasswordLength;
    setState(() {
      _emailError = emailOk ? null : l10n.signInEmailInvalid;
      _passwordError = passwordOk
          ? null
          : l10n.signInPasswordTooShort(_minPasswordLength);
    });
    if (emailOk && passwordOk) ref.read(sessionProvider.notifier).signIn();
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
            spacing: 16,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  tooltip: l10n.actionBack,
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const AppIcon(AppIcons.back),
                ),
              ),
              Text(l10n.signInEmailTitle, style: AppText.pageTitle),
              AppTextField(
                controller: _email,
                label: l10n.signInEmailLabel,
                keyboardType: TextInputType.emailAddress,
                errorText: _emailError,
              ),
              AppTextField(
                controller: _password,
                label: l10n.signInPasswordLabel,
                obscureText: true,
                errorText: _passwordError,
              ),
              PrimaryButton(label: l10n.actionContinue, onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
