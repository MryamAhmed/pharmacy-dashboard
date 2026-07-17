// Flutter imports:
import 'dart:io' show Platform if (dart.library.html) '';

import 'package:flutter/foundation.dart';


class PlatformInfo {
  /// Returns `true` when the app is compiled and running on the web.
  static bool  isWeb = kIsWeb;
  static bool isIOS = Platform.isIOS;
  static bool isAndroid = Platform.isAndroid;
}
