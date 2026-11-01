import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/caution_text.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/session_controller.dart';
import '../../l10n/generated/app_localizations.dart';

/// No wireframe. Built from the components on screen 06.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final signIn = ref.read(sessionProvider.notifier).signIn;
    return Scaffold(
      backgroundColor: DayColors.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.screenPadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - AppSizes.screenPadding * 2,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppLogo(),
                    const Spacer(),
                    Text(
                      l10n.welcomeTitle,
                      style: AppText.pageTitle.copyWith(
                        fontSize: 28,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.welcomeBody,
                      style: AppText.body.copyWith(color: DayColors.textMuted),
                    ),
                    const Spacer(),
                    const CautionText(),
                    const SizedBox(height: 16),
                    PrimaryButton(label: l10n.signInGoogle, onPressed: signIn),
                    if (defaultTargetPlatform == TargetPlatform.iOS) ...[
                      const SizedBox(height: 10),
                      PrimaryButton(
                        label: l10n.signInApple,
                        color: Colors.black,
                        onPressed: signIn,
                      ),
                    ],
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () => context.push(Routes.emailSignIn),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: DayColors.ink,
                        minimumSize: const Size.fromHeight(54),
                        side: const BorderSide(color: DayColors.borderStrong),
                        textStyle: AppText.button,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(l10n.signInEmail),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
