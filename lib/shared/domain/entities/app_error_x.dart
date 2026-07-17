// Project imports:
import '../../../l10n/app_localizations.dart';
import 'app_error.dart';

/// Convenience extension on [AppError] for user-facing message resolution.
extension AppErrorX on AppError {
  /// Returns [message] if present, else a localized fallback based on [isNetwork].
  String resolveMessage(AppLocalizations l10n) =>
      message ?? (isNetwork ? l10n.errorNetwork : l10n.errorGeneric);
}
