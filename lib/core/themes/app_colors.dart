// Flutter imports:
import 'package:flutter/material.dart';

/// All colors used in the app.
///
/// Per PR guidelines: never use raw `Color(0xFF...)` or `Colors.*` in widgets —
/// add a constant here and reference it.
///
/// **Opacity variants always derive from their base color** via
/// `baseColor.withValues(alpha: ...)`. Never give an opacity variant its own
/// hex value — that breaks the link between the base and its variants and
/// makes recoloring the brand a multi-line change.
class AppColors {
  AppColors._();

  // ---------- Brand ----------
  /// Primary brand color.
  static const Color primaryColor = Color(0xFF167986);
  static final Color primaryColorWithOpacity10 = primaryColor.withValues(
    alpha: 0.10,
  );
  static final Color primaryColorWithOpacity12 = primaryColor.withValues(
    alpha: 0.12,
  );

  // ---------- Surfaces ----------
  static const Color mainWhiteColor = Color(0xFFF9FAFB);
  static const Color containersGrayColor = Color(0xFFF3F5F6);

  /// Fully transparent — use instead of a bare `Colors.transparent` in widgets.
  static const Color transparent = Color(0x00000000);

  // ---------- Borders ----------
  static const Color textFieldBorder = Color(0xFFDAE0E7);

  // ---------- Text ----------
  static const Color blackColor = Color(0xFF000000);
  static const Color textBlack = Color(0xFF131720);

  /// Default color for [AppTextStyles]' unsuffixed variants (e.g. `regular14`,
  /// `bold24`) — baked in as their default instead of adapting to the theme.
  static const Color titleColor = Color(0xFF404040);
  static const Color textDarkGray = Color(0xFF333333);
  static const Color textGray = Color(0xFF627084);
  static const Color textWhite = Colors.white;
  static const Color hintTextGray = Color(0xFF9CA3AF);

  // ---------- Feedback ----------
  static const Color successGreenColor = Color(0xFF25B15F);
  static const Color warningOrangeColor = Color(0xFFF1B239);
  static const Color mainRedColor = Color(0xFFE23636);
  static const Color errorRedColor = Color(0xFFFF4938);

  // ---------- Button states ----------
  static const Color disabledButtonColor = Color(0xFFE7E8EE);
  static const Color disabledButtonTextColor = Color(0xFFC5C6E4);

  // ---------- appscaffold background ----------
  static const Color screenBackground = Color(0xFFF9F9F9);

  // ---------- styles color ----------
  static const Color hintStyleColor = Color(0xFF8C8C8C);

  static const Color dashboardItem2Color = Color(0xFF27AE60);
  static const Color dashboardItem3Color = Color(0xFFF39C12);
  static const Color dashboardItem4Color = Color(0xFF9C27B0);
}
