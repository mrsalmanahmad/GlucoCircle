import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  LicenseRegistry.addLicense(_fontLicenses);
  runApp(const ProviderScope(child: GlucoCircleApp()));
}

Stream<LicenseEntry> _fontLicenses() async* {
  const fonts = {
    'Plus Jakarta Sans': 'assets/fonts/OFL-PlusJakartaSans.txt',
    'Fraunces': 'assets/fonts/OFL-Fraunces.txt',
  };
  for (final MapEntry(key: family, value: path) in fonts.entries) {
    yield LicenseEntryWithLineBreaks([
      family,
    ], await rootBundle.loadString(path));
  }
}
