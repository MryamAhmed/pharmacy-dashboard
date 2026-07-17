// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'app_colors.dart';

/// All text styles used in the app.
///
/// **Convention:**
///   * Styles **without** a colour suffix (e.g. `regular14`, `bold24`) leave
///     `color` unset, so the rendered colour is inherited from the surrounding
///     [DefaultTextStyle] — which Flutter derives from `Theme.textTheme`. This
///     means they automatically swap between dark text on a light theme and
///     light text on a dark theme.
///   * Styles **with** a colour suffix (e.g. `regular14Gray`, `medium16White`)
///     bake that specific colour in and do NOT adapt to the active theme.
///     Use them only when the colour is intentional (secondary text, errors,
///     text on a colored button, etc.).
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _style(
    double fontSize,
    FontWeight weight, {
    Color? color,
    bool isUnderline = false,
  }) => TextStyle(
    fontSize: fontSize.spMin,
    fontWeight: weight,
    color: color,
    decoration: isUnderline ? TextDecoration.underline : null,
  );

  // ---------- Adaptive (no baked colour) ----------

  static TextStyle get regular12 => _style(12, FontWeight.normal);
  static TextStyle get medium12 => _style(12, FontWeight.w500);
  static TextStyle get bold12 => _style(12, FontWeight.bold);

  static TextStyle get regular14 => _style(14, FontWeight.normal);
  static TextStyle get medium14 => _style(14, FontWeight.w500);
  static TextStyle get bold14 => _style(14, FontWeight.bold);

  static TextStyle get regular16 => _style(16, FontWeight.normal);
  static TextStyle get medium16 => _style(16, FontWeight.w500);
  static TextStyle get bold16 => _style(16, FontWeight.bold);

  static TextStyle get regular18 => _style(18, FontWeight.normal);
  static TextStyle get medium18 => _style(18, FontWeight.w500);
  static TextStyle get bold18 => _style(18, FontWeight.bold);

  static TextStyle get medium20 => _style(20, FontWeight.w500);
  static TextStyle get bold20 => _style(20, FontWeight.bold);

  static TextStyle get bold24 => _style(24, FontWeight.bold);
  static TextStyle get bold28 => _style(28, FontWeight.bold);

  // ---------- Explicit-colour variants ----------

  static TextStyle get regular12Gray =>
      _style(12, FontWeight.normal, color: AppColors.textGray);
  static TextStyle get regular14Gray =>
      _style(14, FontWeight.normal, color: AppColors.textGray);
  static TextStyle get regular14Red =>
      _style(14, FontWeight.normal, color: AppColors.mainRedColor);

  static TextStyle get medium14White =>
      _style(14, FontWeight.w500, color: AppColors.textWhite);
  static TextStyle get medium16White =>
      _style(16, FontWeight.w500, color: AppColors.textWhite);

  static TextStyle get bold16White =>
      _style(16, FontWeight.bold, color: AppColors.textWhite);
  static TextStyle get bold20White =>
      _style(20, FontWeight.bold, color: AppColors.textWhite);
  static TextStyle get bold24White =>
      _style(24, FontWeight.bold, color: AppColors.textWhite);
  static TextStyle get bold28White =>
      _style(28, FontWeight.bold, color: AppColors.textWhite);
}
