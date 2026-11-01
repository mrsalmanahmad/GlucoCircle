import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_palette.dart';
import '../theme/app_text.dart';

/// The standard "consult your doctor" line. Use this everywhere medical topics
/// appear so the wording stays the same. See docs/MVP_PLAN.md.
class CautionText extends StatelessWidget {
  const CautionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).caution,
      style: AppText.small.copyWith(color: context.palette.textSecondary),
    );
  }
}
