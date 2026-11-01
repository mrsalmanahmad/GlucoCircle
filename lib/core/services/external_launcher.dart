import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens a phone dialer or maps link outside the app. Returns false if it
/// couldn't, so callers can tell the person instead of failing silently.
typedef ExternalLauncher = Future<bool> Function(Uri uri);

final externalLauncherProvider = Provider<ExternalLauncher>((ref) {
  return (uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on PlatformException {
      return false;
    }
  };
});
