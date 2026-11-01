/// Holds risky text for review before anyone else can see it. Apple guideline
/// 1.2 requires a filter.
///
/// TEMPORARY LOCATION: this must move to the createPost and createGlow Cloud
/// Functions, because anything checked only in the app can be bypassed.
abstract final class ContentFilter {
  static const _medicine =
      r'(insulin|medicine|medication|metformin|tablets?|pills?|dawa|dawai|goli|goliyan)';
  static const _stop =
      r'(stop|stopped|skip|skipped|quit|leave|chhor|chor|band)';

  static final _patterns = <RegExp>[
    // "stop your insulin", "skip the medicine"
    RegExp('\\b$_stop\\w*\\s+(\\w+\\s+){0,2}$_medicine\\b'),
    // Roman Urdu word order: "insulin chhor do", "dawai band kar do"
    RegExp('\\b$_medicine\\s+(\\w+\\s+){0,1}$_stop\\b'),
    // Selling and miracle claims.
    RegExp(r'\b(cure[sd]?|curing|herbal|nuskha|miracle|guaranteed)\b'),
    // Taking people off the app.
    RegExp(r'\b(whatsapp|telegram|dm me|inbox me|contact me)\b'),
    // Phone numbers.
    RegExp(r'\+?\d[\d\s-]{8,}\d'),
    // Links.
    RegExp(r'(https?://|www\.|\b[\w-]+\.(com|pk|net|org|io|co)\b)'),
  ];

  static bool shouldHold(String text) {
    final lower = text.toLowerCase();
    return _patterns.any((pattern) => pattern.hasMatch(lower));
  }
}
