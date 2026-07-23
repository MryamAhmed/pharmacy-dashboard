/// Path segments for [GoRouter] routes.
///
/// Per project convention: never hardcode a path string in navigation calls —
/// always reference these constants (and [AppRouteNames] for named navigation).
abstract final class AppRoutes {
  const AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String rateDetails = '/rate-details';
}

abstract final class AppRouteNames {
  const AppRouteNames._();

  static const String splash = 'splash';
  static const String login = 'login';
  static const String home = 'home';
  static const String rateDetails = 'rateDetails';
}
