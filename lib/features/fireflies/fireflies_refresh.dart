import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';

/// Glows fade with time, not with a data change, so nothing would otherwise
/// tell the screen that one has expired. Rechecks while the screen is open.
mixin FirefliesRefresh<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  static const _interval = Duration(seconds: 30);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_interval, (_) {
      ref.invalidate(glowsProvider);
      ref.invalidate(myGlowProvider);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
