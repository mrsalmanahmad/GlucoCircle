import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/app_text.dart';

/// A 16 radius outlined input that follows the current mood.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.hint,
    this.label,
    this.errorText,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.obscureText = false,
    this.style,
    this.hintStyle,
    this.onChanged,
    this.fillColor,
    this.borderColor,
  });

  final TextEditingController controller;
  final String? hint;
  final String? label;
  final String? errorText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: borderColor ?? palette.chipBorder),
    );
    return TextField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      textCapitalization: keyboardType == TextInputType.emailAddress
          ? TextCapitalization.none
          : TextCapitalization.sentences,
      style: style ?? AppText.body.copyWith(color: palette.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: hintStyle,
        errorText: errorText,
        counterText: '',
        filled: true,
        fillColor: fillColor ?? palette.surface,
        contentPadding: const EdgeInsets.all(14),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: palette.accent, width: 1.5),
        ),
      ),
    );
  }
}
