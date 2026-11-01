import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

class AppToggle extends StatelessWidget {
  const AppToggle({
    super.key,
    required this.value,
    required this.onChanged,
    required this.semanticLabel,
  });

  static const _width = 44.0;
  static const _height = 26.0;
  static const _knob = 20.0;
  static const _duration = Duration(milliseconds: 150);

  final bool value;
  final ValueChanged<bool> onChanged;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final animate = !MediaQuery.disableAnimationsOf(context);
    return Semantics(
      label: semanticLabel,
      toggled: value,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(!value),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: AnimatedContainer(
            duration: animate ? _duration : Duration.zero,
            width: _width,
            height: _height,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: value ? palette.toggleOnTrack : palette.toggleOffTrack,
              borderRadius: BorderRadius.circular(_height / 2),
            ),
            child: AnimatedAlign(
              duration: animate ? _duration : Duration.zero,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: _knob,
                height: _knob,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? palette.toggleOnKnob : palette.toggleOffKnob,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
