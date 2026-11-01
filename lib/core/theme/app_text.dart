import 'package:flutter/painting.dart';

abstract final class AppFonts {
  static const jakarta = 'PlusJakartaSans';

  /// Night and Morning headings and quotes only. Never on Day screens.
  static const fraunces = 'Fraunces';
}

/// Colours are left out so text inherits them from the current mood.
abstract final class AppText {
  static const nightTitle = TextStyle(
    fontFamily: AppFonts.fraunces,
    fontSize: 34,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.34,
  );
  static const nightHeading = TextStyle(
    fontFamily: AppFonts.fraunces,
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 1.15,
  );
  static const quote = TextStyle(
    fontFamily: AppFonts.fraunces,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    height: 1.45,
  );

  static const pageTitle = TextStyle(
    fontFamily: AppFonts.jakarta,
    fontSize: 26,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.52,
  );
  static const sheetTitle = TextStyle(
    fontFamily: AppFonts.jakarta,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );
  static const button = TextStyle(
    fontFamily: AppFonts.jakarta,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const rowTitle = TextStyle(
    fontFamily: AppFonts.jakarta,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );
  static const body = TextStyle(
    fontFamily: AppFonts.jakarta,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );
  static const bodySmall = TextStyle(
    fontFamily: AppFonts.jakarta,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );
  static const chip = TextStyle(
    fontFamily: AppFonts.jakarta,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
  static const small = TextStyle(
    fontFamily: AppFonts.jakarta,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
  static const navLabel = TextStyle(
    fontFamily: AppFonts.jakarta,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}
