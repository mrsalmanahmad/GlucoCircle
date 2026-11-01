import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/app_text.dart';

/// The full-width main action of a screen. Follows the current mood.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
  });

  final String label;
  final VoidCallback? onPressed;

  /// Overrides the mood's accent, for example `DayColors.danger` on Report.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color ?? palette.accent,
        foregroundColor: color == null ? palette.onAccent : Colors.white,
        // Minimum, not fixed, so large system text can grow the button.
        minimumSize: Size.fromHeight(palette.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: AppText.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(palette.buttonRadius),
        ),
      ),
      child: Text(label, textAlign: TextAlign.center),
    );
  }
}
