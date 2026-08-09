// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/shared/presentation/widgets/app_text.dart';

// Project imports:
import '../../../core/constants/app_values.dart';
import '../../../core/constants/test_keys.dart';
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
    this.labelStyle,
    this.contentPadding,
    this.fillColor,
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
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          AppText(
            key: const Key(TestKeys.lableText),
            text: labelText!,
            style: labelStyle,
            textAlign: TextAlign.center,
          ),
        if (labelText != null) const Gap(AppSpace.s8),
        TextFormField(
          onTapUpOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
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
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: AppPaddings.p16,
                  vertical: AppPaddings.p12,
                ),
            errorText: errorText,
            prefixIcon: prefix,
            suffixIcon: suffix,
            fillColor: fillColor,
          ),
        ),
      ],
    );
  }
}
