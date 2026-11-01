import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_palette.dart';
import 'app_text.dart';

abstract final class AppTheme {
  static final daySystemUi = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  );
  static final nightSystemUi = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  );

  static final day = _build(Brightness.light, AppPalette.day);
  static final night = _build(Brightness.dark, AppPalette.night);

  static ThemeData _build(Brightness brightness, AppPalette palette) {
    final base = ThemeData(
      brightness: brightness,
      fontFamily: AppFonts.jakarta,
    );
    return base.copyWith(
      scaffoldBackgroundColor: palette.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.accent,
        brightness: brightness,
        primary: palette.accent,
        onPrimary: palette.onAccent,
        surface: palette.surface,
        onSurface: palette.textPrimary,
        error: DayColors.danger,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: palette.textPrimary,
        displayColor: palette.textPrimary,
      ),
      extensions: [palette],
    );
  }
}

/// Puts a route in the Night mood: dark colours and a light status bar.
class NightMood extends StatelessWidget {
  const NightMood({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.nightSystemUi,
      child: Theme(data: AppTheme.night, child: child),
    );
  }
}
