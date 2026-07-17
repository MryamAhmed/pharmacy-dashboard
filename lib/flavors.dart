enum AppFlavor { dev, staging, prod }

/// Runtime flavor configuration. Set in `main_*.dart` before calling
/// [mainCommon].
///
/// [baseUrl] is intentionally a placeholder for this template — point each
/// flavor at the real Pharmacy API before shipping.
class Flavor {
  Flavor._();

  static AppFlavor appFlavor = AppFlavor.dev;

  static String get flavorName {
    switch (appFlavor) {
      case AppFlavor.dev:
        return 'dev';
      case AppFlavor.staging:
        return 'staging';
      case AppFlavor.prod:
        return 'prod';
    }
  }

  /// Base URL for network requests. Configure per environment.
  static String get baseUrl {
    switch (appFlavor) {
      case AppFlavor.dev:
        return 'https://api.example.com';
      case AppFlavor.staging:
        return 'https://api.example.com';
      case AppFlavor.prod:
        return 'https://api.example.com';
    }
  }

  /// Whether the network logger should be enabled. Disabled in prod.
  static bool get enableNetworkLogger => appFlavor != AppFlavor.prod;
}
