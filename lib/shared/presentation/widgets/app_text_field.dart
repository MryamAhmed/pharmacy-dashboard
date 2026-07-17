// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../core/themes/app_text_style.dart';

/// Shared text input.
///
/// Per PR guidelines: every text input in the app must use this widget
/// instead of a bare [TextField] / [TextFormField].
///
/// Deliberately thin: border/fill colours and error styling come from the
/// app's [InputDecorationTheme] (see `MainTheme`) rather than being
/// hardcoded here, so every field automatically follows the active theme
/// (including dark mode) with zero per-field colour wiring.
class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.fieldKey,
    required this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.textDirection,
    this.maxLines = 1,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.focusNode,
  });

  /// Required for testing purposes — every field must be locatable by key.
  final Key fieldKey;

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;

  /// Inline validation message. Passing a non-null value switches the field
  /// to its error border/colour via the app theme.
  final String? errorText;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  /// Forces the input direction (e.g. LTR for emails regardless of app
  /// locale). Leave null to inherit the ambient [Directionality].
  final TextDirection? textDirection;

  final int? maxLines;
  final Widget? prefix;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textDirection: textDirection,
      // Obscured fields are always single-line regardless of [maxLines].
      maxLines: obscureText ? 1 : maxLines,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      validator: validator,
      focusNode: focusNode,
      style: AppTextStyles.regular14,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );
  }
}
