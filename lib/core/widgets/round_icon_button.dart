import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/app_sizes.dart';
import 'app_icon.dart';

/// The 44 round button used in screen headers.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final AppIcons icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: palette.surface,
        shape: CircleBorder(side: BorderSide(color: palette.border)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox.square(
            dimension: AppSizes.minTapTarget,
            child: Center(child: AppIcon(icon, size: 22)),
          ),
        ),
      ),
    );
  }
}
