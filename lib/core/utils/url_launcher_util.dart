// Package imports:
import 'package:url_launcher/url_launcher.dart';

/// Thin wrapper around [url_launcher] so callers (cubits) depend on an
/// injectable abstraction instead of static functions.
///
/// Kept as a plain class (registered as a `@lazySingleton` in [AppMainModule])
/// so it can be mocked in tests — cubits never call `url_launcher` directly.
class UrlLauncherUtil {
  /// Opens [url] in an external browser application.
  ///
  /// Returns `true` if the URL was launched successfully, `false` otherwise
  /// (e.g. the URL could not be parsed or no handler is available).
  Future<bool> openExternal(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
