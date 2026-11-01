import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';

/// The ring and name from the top of screen 06.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: DayColors.primary, width: 6),
          ),
        ),
        Text(
          AppLocalizations.of(context).appTitle,
          style: AppText.sectionTitle.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.18,
          ),
        ),
      ],
    );
  }
}
