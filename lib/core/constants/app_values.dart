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
  static const double s50 = 50;
  static const double s56 = 56;
  static const double s58 = 58;
  static const double s64 = 64;
  static const double s66 = 66;
  static const double s74 = 74;
  static const double s80 = 80;
  static const double s100 = 100;
}

class AppPaddings {
  AppPaddings._();

  static const double p2 = 2;
  static const double p4 = 4;
  static const double p6 = 6;
  static const double p8 = 8;
  static const double p10 = 10;
  static const double p12 = 12;
  static const double p14 = 14;
  static const double p16 = 16;
  static const double p18 = 18;
  static const double p20 = 20;
  static const double p22 = 22;
  static const double p24 = 24;
  static const double p26 = 26;
  static const double p28 = 28;
  static const double p32 = 32;
  static const double p36 = 36;
  static const double p38 = 38;
  static const double p40 = 40;
  static const double p46 = 46;
  static const double p48 = 48;
  static const double p56 = 56;
  static const double p64 = 64;
  static const double p66 = 66;
  static const double p80 = 80;
  static const double p100 = 100;
}

class AppMargins {
  AppMargins._();

  static const double m2 = 2;
  static const double m4 = 4;
  static const double m6 = 6;
  static const double m8 = 8;
  static const double m10 = 10;
  static const double m12 = 12;
  static const double m14 = 14;
  static const double m16 = 16;
  static const double m18 = 18;
  static const double m20 = 20;
  static const double m22 = 22;
  static const double m24 = 24;
  static const double m26 = 26;
  static const double m28 = 28;
  static const double m32 = 32;
  static const double m36 = 36;
  static const double m38 = 38;
  static const double m40 = 40;
  static const double m46 = 46;
  static const double m48 = 48;
  static const double m56 = 56;
  static const double m64 = 64;
  static const double m66 = 66;
  static const double m80 = 80;
  static const double m100 = 100;
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

/// Dimensions for the shared [AppBarWidget].
class AppBarWidgetDimens {
  AppBarWidgetDimens._();

  /// Toolbar height. Matches [MainTheme]'s `AppBarTheme.toolbarHeight`.
  static const double height = 70;

  /// Width/height of the back icon.
  static const double backIconSize = 24;
}
