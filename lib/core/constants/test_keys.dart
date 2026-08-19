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

  // ---------- Shared — text field (AppSearchWidget) ----------
  static const String lableText = 'lableText';
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
  static const String loginRememberMeCheckbox = 'loginRememberMeCheckbox';
  static const String loginRememberMeLabel = 'loginRememberMeLabel';
  static const String loginForgotPasswordButton = 'loginForgotPasswordButton';
  static const String loginGeneralError = 'loginGeneralError';
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
  static const String homeDashboardTitle1 = 'homeDashboardTitle1';
  static const String homeDashboardTitle2 = 'homeDashboardTitle2';
  static const String homeDashboardTitle3 = 'homeDashboardTitle3';
  static const String homeDashboardTitle4 = 'homeDashboardTitle4';
  static const String homeDashboardSubTitle1 = 'homeDashboardSubTitle1';
  static const String homeDashboardSubTitle2 = 'homeDashboardSubTitle2';
  static const String homeDashboardSubTitle3 = 'homeDashboardSubTitle3';
  static const String homeDashboardSubTitle4 = 'homeDashboardSubTitle4';
  static const String homeQuickActions = 'homeQuickActions';
  static const String approveRating = 'approveRating';
  static const String verifyUsers = 'verifyUsers';
  static const String verifyParmacies = 'verifyParmacies';

  static const String pharmacyManagementPage = 'pharmacyManagementPage';
  static const String ratePage = 'ratePage';
  static const String userManagementPage = 'userManagementPage';

  // rate — individual tab screens
  static const String numberOfPending = 'numberOfPending';
  static const String rateFilterTab = 'rateFilterTab';
  static const String textAvatarLabel = 'textAvatarLabel';
  static const String pharmacyRateLabel = 'pharmacyRateLabel';
  static const String userRateLabel = 'userRateLabel';
  static const String rateStarsLabel = 'rateStarsLabel';
  static const String rateDurationLabel = 'rateDurationLabel';
  static const String rateDescriptionLabel = 'rateDescriptionLabel';
  static const String rateButtonLabel = 'rateButtonLabel';
  static const String rateCardItem = 'rateCardItem';
  static const String rateEmptyState = 'rateEmptyState';

  // ---------- Rate details screen ----------
  static const String rateDetailsPage = 'rateDetailsPage';
  static const String rateDetailsPharmacyName = 'rateDetailsPharmacyName';
  static const String rateDetailsPharmacyAddress = 'rateDetailsPharmacyAddress';
  static const String rateDetailsUserName = 'rateDetailsUserName';
  static const String rateDetailsUserAddress = 'rateDetailsUserAddress';
  static const String rateDetailsStars = 'rateDetailsStars';
  static const String rateDetailsStatus = 'rateDetailsStatus';
  static const String rateDetailsDate = 'rateDetailsDate';
  static const String rateDetailsDescription = 'rateDetailsDescription';
  static const String rateDetailsRateLabel = 'rateDetailsRateLabel';
  static const String rateDetailsRatingGivenLabel =
      'rateDetailsRatingGivenLabel';
  static const String rateDetailsRatingTextLabel = 'rateDetailsRatingTextLabel';
  static const String rateDetailsContextLabel = 'rateDetailsContextLabel';
  static const String rateDetailsPostionContext = 'rateDetailsPostionContext';
  static const String rateDetailsShiftDateContext =
      'rateDetailsShiftDateContext';
  static const String rateDetailsPreviousRate = 'rateDetailsPreviousRate';
  static const String rateDetailsButtonLabel = 'rateDetailsButtonLabel';

  // pharmacymanagement — individual tab screens
  static const String numberOfRegistered = 'numberOfPendingPharmacies';
  static const String pharmacyCardItem = 'pharmacyCardItem';
  static const String pharmacyName = 'pharmacyName';
  static const String pharmacyVerified = 'pharmacyVerified';
  static const String pharmacyLocation = 'pharmacyLocation';
  static const String pharmacyOwner = 'pharmacyOwner';
  static const String pharmacyTime = 'pharmacyTime';
  static const String searchBarWidget = 'searchBarWidget';
}
