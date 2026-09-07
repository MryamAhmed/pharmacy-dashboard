// Package imports:
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Shared utility for checking real internet reachability.
///
/// This checks whether the device can reach external internet endpoints, not
/// only whether it is connected to Wi-Fi or mobile data.
class InternetConnectionUtility {
  const InternetConnectionUtility._();

  /// Returns `true` only when internet access is confirmed by the checker.
  ///
  /// If the checker itself throws, the connection state is unknown, so callers
  /// should avoid showing the specific no-internet message.
  static Future<bool> hasInternetAccess() async {
    try {
      return await InternetConnection().hasInternetAccess;
    } catch (_) {
      return true;
    }
  }
}
