import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A glowing dot. Pulses unless the system asks for reduced motion.
class FireflyGlow extends StatefulWidget {
  const FireflyGlow({
    super.key,
    this.size = 16,
    this.delay = Duration.zero,
    this.animate = true,
  });

  final double size;

  /// Start offset, so a sky of fireflies doesn't pulse in step.
  final Duration delay;

  /// False for small decorative dots, such as on the Community banner.
  final bool animate;

  @override
  State<FireflyGlow> createState() => _FireflyGlowState();
}

class _FireflyGlowState extends State<FireflyGlow>
    with SingleTickerProviderStateMixin {
  // One pulse out and back is 3.2 s in the wireframes.
  static const _halfPulse = Duration(milliseconds: 1600);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _halfPulse,
    value: widget.delay.inMilliseconds / _halfPulse.inMilliseconds % 1,
  );
  late final Animation<double> _curve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.animate && !MediaQuery.disableAnimationsOf(context)) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dot = DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: NightColors.glow,
        boxShadow: [
          BoxShadow(color: Color(0x8CFFC857), blurRadius: 14, spreadRadius: 5),
          BoxShadow(color: Color(0x2EFFAA3C), blurRadius: 36, spreadRadius: 12),
        ],
      ),
      child: SizedBox.square(dimension: widget.size),
    );
    return AnimatedBuilder(
      animation: _curve,
      builder: (context, child) => Opacity(
        opacity: 0.85 + 0.15 * _curve.value,
        child: Transform.scale(scale: 1 + 0.4 * _curve.value, child: child),
      ),
      child: dot,
    );
  }
}
