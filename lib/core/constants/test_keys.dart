/// Test keys used with `Key(...)` / `ValueKey(...)` in widgets.
///
/// Per PR guidelines: every widget Key must reference a constant from this
/// class. Add new constants here before using them in widgets.
class TestKeys {
  const TestKeys._();

  // ---------- Common ----------
  static const String autoDirection = 'autoDirection';
  static const String appScaffold = 'appScaffold';

  // ---------- Shared — responsive (AppScaffold / ResponsiveLayout) ----------
  static const String responsiveMobile = 'responsiveMobile';
  static const String responsiveWeb = 'responsiveWeb';

  // ---------- Shared — search field (AppSearchWidget) ----------
  static const String appSearchField = 'appSearchField';

  // ---------- Shared — app bar (AppBarWidget) ----------
  static const String appBarWidget = 'appBarWidget';
  static const String appBarBackButton = 'appBarBackButton';
  static const String appBarTitle = 'appBarTitle';

  // ---------- Splash ----------
  static const String splashPage = 'splashPage';
  static const String splashLogo = 'splashLogo';

  // ---------- Login ----------
  static const String loginPage = 'loginPage';
  static const String loginScaffold = 'loginScaffold';
  static const String loginTitle = 'loginTitle';
  static const String loginSubtitle = 'loginSubtitle';
  static const String loginEmailField = 'loginEmailField';
  static const String loginPasswordField = 'loginPasswordField';
  static const String loginPasswordVisibilityToggle =
      'loginPasswordVisibilityToggle';
  static const String loginSubmitButton = 'loginSubmitButton';

  // ---------- Home shell (bottom navigation) ----------
  static const String homeShellScaffold = 'homeShellScaffold';
  static const String homeBottomNavBar = 'homeBottomNavBar';
  static const String homeNavHomeTab = 'homeNavHomeTab';
  static const String homeNavPharmacyManagementTab =
      'homeNavPharmacyManagementTab';
  static const String homeNavRateTab = 'homeNavRateTab';
  static const String homeNavUserManagementTab = 'homeNavUserManagementTab';

  // Home — individual tab screens
  static const String homeTabPage = 'homeTabPage';
  static const String pharmacyManagementPage = 'pharmacyManagementPage';
  static const String ratePage = 'ratePage';
  static const String userManagementPage = 'userManagementPage';
}
