import 'package:flutter/material.dart';

import 'app_colors.dart';

/// The values shared widgets need that change between Day and Night.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.onAccent,
    required this.buttonHeight,
    required this.buttonRadius,
    required this.chipSelectedBg,
    required this.chipSelectedFg,
    required this.chipBg,
    required this.chipFg,
    required this.chipBorder,
    required this.toggleOnTrack,
    required this.toggleOnKnob,
    required this.toggleOffTrack,
    required this.toggleOffKnob,
  });

  final Color background;
  final Color surface;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color onAccent;
  final double buttonHeight;
  final double buttonRadius;
  final Color chipSelectedBg;
  final Color chipSelectedFg;
  final Color chipBg;
  final Color chipFg;
  final Color chipBorder;
  final Color toggleOnTrack;
  final Color toggleOnKnob;
  final Color toggleOffTrack;
  final Color toggleOffKnob;

  static const day = AppPalette(
    background: DayColors.background,
    surface: DayColors.surface,
    border: DayColors.border,
    textPrimary: DayColors.ink,
    textSecondary: DayColors.textMuted,
    accent: DayColors.primary,
    onAccent: Colors.white,
    buttonHeight: 54,
    buttonRadius: 16,
    chipSelectedBg: DayColors.ink,
    chipSelectedFg: Colors.white,
    chipBg: DayColors.surface,
    chipFg: DayColors.textBody,
    chipBorder: DayColors.border,
    toggleOnTrack: DayColors.primary,
    toggleOnKnob: Colors.white,
    toggleOffTrack: DayColors.control,
    toggleOffKnob: Colors.white,
  );

  static const night = AppPalette(
    background: NightColors.background,
    surface: NightColors.surface,
    border: NightColors.divider,
    textPrimary: NightColors.cream,
    textSecondary: NightColors.sub,
    accent: NightColors.glow,
    onAccent: NightColors.onGlow,
    buttonHeight: 56,
    buttonRadius: 28,
    chipSelectedBg: NightColors.glow,
    chipSelectedFg: NightColors.onGlow,
    chipBg: NightColors.surface,
    chipFg: NightColors.chipText,
    chipBorder: NightColors.border,
    toggleOnTrack: NightColors.glow,
    toggleOnKnob: NightColors.onGlow,
    toggleOffTrack: NightColors.border,
    toggleOffKnob: NightColors.muted,
  );

  @override
  AppPalette copyWith() => this;

  // Moods switch per route, never by animating between them.
  @override
  AppPalette lerp(AppPalette? other, double t) =>
      other != null && t >= 0.5 ? other : this;
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}
