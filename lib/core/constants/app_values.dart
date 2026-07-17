/// All spacing values — gaps, paddings, and margins — live here as `const`
/// doubles.
///
/// Per the flutter-pr-review guidelines: use `AppSpace.sX` for every `Gap`,
/// `EdgeInsets`, padding, and margin. There is no separate `AppPadding` /
/// `AppMargin` class — every spacing constant lives in this one.
class AppSpace {
  AppSpace._();

  static const double s2 = 2;
  static const double s4 = 4;
  static const double s6 = 6;
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s24 = 24;
  static const double s26 = 26;
  static const double s28 = 28;
  static const double s32 = 32;
  static const double s36 = 36;
  static const double s38 = 38;
  static const double s40 = 40;
  static const double s46 = 46;
  static const double s48 = 48;
  static const double s56 = 56;
  static const double s64 = 64;
  static const double s66 = 66;
  static const double s80 = 80;
  static const double s100 = 100;
}

/// Responsive breakpoint (logical pixels). Width at/above this renders the
/// web/desktop layout (see [AppScaffold]'s `webBody`); below it renders the
/// mobile layout.
class AppBreakpoints {
  AppBreakpoints._();

  static const double web = 900;
}

/// Dimensions for the shared [AppButtonWidget]. Plain `const` logical
/// pixels — apply `.h`/`.r` via ScreenUtil at the use site.
class AppButtonDimens {
  AppButtonDimens._();

  /// Default button height.
  static const double height = 52;

  /// Default corner radius.
  static const double radius = 12;

  /// Width/height of the loading spinner shown in place of the label while
  /// `isLoading` is true.
  static const double loaderSize = 20;

  static const double loaderStrokeWidth = 2;
}

/// Dimensions for the shared bottom-navigation home shell
/// ([HomeShellScreen] / [HomeBottomNavBar]).
class HomeShellDimens {
  HomeShellDimens._();

  /// Size of each bottom-nav tab icon.
  static const double navIconSize = 24;
}

/// Dimensions for the splash screen.
class SplashDimens {
  SplashDimens._();

  /// Width of the centered logo over the splash background.
  static const double logoWidth = 140;
}
