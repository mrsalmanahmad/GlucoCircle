import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text.dart';

/// Drawn 36 high as in the wireframes, with a 44 high tap area around it.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final background = selected ? palette.chipSelectedBg : palette.chipBg;
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: (AppSizes.minTapTarget - AppSizes.chipHeight) / 2,
          ),
          child: Container(
            constraints: const BoxConstraints(minHeight: AppSizes.chipHeight),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(AppSizes.chipHeight / 2),
              border: Border.all(
                color: selected ? background : palette.chipBorder,
              ),
            ),
            // The factors keep the chip as wide as its text, even in a Wrap.
            child: Align(
              widthFactor: 1,
              heightFactor: 1,
              child: Text(
                label,
                style: AppText.chip.copyWith(
                  color: selected ? palette.chipSelectedFg : palette.chipFg,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
