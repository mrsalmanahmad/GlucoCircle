import 'package:flutter/painting.dart';

// Values come from docs/wireframes/README.md. Screens should read colours from
// AppPalette where a value differs by mood, and from here otherwise.

/// Day mood: Community, Share, Signs, Healthy.
abstract final class DayColors {
  static const primary = Color(0xFF1E4FD8);
  static const primaryDark = Color(0xFF163BA6);
  static const ink = Color(0xFF0F1A2E);
  static const textBody = Color(0xFF34405A);
  static const textMuted = Color(0xFF4F5B6E);
  static const textFaint = Color(0xFF5B6576);
  static const background = Color(0xFFF4F6FA);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE3E8F0);
  static const borderStrong = Color(0xFFCBD3E1);
  static const control = Color(0xFFB8C2D3);
  static const selectedRow = Color(0xFFF3F6FE);
  static const selectedTile = Color(0xFFE8EEFD);
  static const successText = Color(0xFF166534);
  static const successBg = Color(0xFFE8F5EC);
  static const warnText = Color(0xFF8A3D05);
  static const warnBg = Color(0xFFFFF4E5);
  static const danger = Color(0xFFB42318);
  static const dangerText = Color(0xFF8F1B12);
  static const dangerBg = Color(0xFFFDECEC);
  static const dangerBody = Color(0xFF3B0D09);
  static const divider = Color(0xFFEEF1F6);
  static const tagBg = Color(0xFFF1F3F8);
  static const plateRing = Color(0xFFE8ECF3);
  static const scrim = Color(0x730F1A2E);

  static const moodGood = Color(0xFF22C55E);
  static const moodOkay = Color(0xFF3B82F6);
  static const moodLow = Color(0xFFF59E0B);
  static const moodStruggling = Color(0xFF8B5CF6);

  static const plateVegetables = Color(0xFF22A55B);
  static const plateProtein = Color(0xFFE07B39);
  static const plateGrains = Color(0xFFC9A227);
}

/// Night mood: Fireflies.
abstract final class NightColors {
  static const background = Color(0xFF0B1026);
  static const surface = Color(0xFF151C3B);
  static const horizon = Color(0xFF121A3D);
  static const horizonBorder = Color(0xFF2A3570);
  static const bubble = Color(0xFF1C2449);
  static const border = Color(0xFF323C6E);
  static const divider = Color(0xFF262F57);
  static const glow = Color(0xFFFFC857);
  static const glowLight = Color(0xFFFFD98A);
  static const onGlow = Color(0xFF1A1300);
  static const cream = Color(0xFFF3F1EA);
  static const sub = Color(0xFFC9CDE3);
  static const muted = Color(0xFFA9B0CF);
  static const hint = Color(0xFF8E97C4);
  static const chipText = Color(0xFFE4E6F2);
  static const cardInk = Color(0xFF141833);
}

/// Morning mood: the morning-after card (v1.1).
abstract final class MorningColors {
  static const background = Color(0xFFFBF6EC);
  static const ink = Color(0xFF1B1A2E);
  static const muted = Color(0xFF5E5A4E);
  static const border = Color(0xFFECE3D1);
}
