/// App-wide plain constants.
///
/// Trimmed for the Pharmacy template — add product-specific values here as the
/// app grows.
class AppConstants {
  AppConstants._();

  static const String appName = 'Pharmacy';
  static const String appCopyrightYear = '  ©  2026';

  static const String dot = '.';
  static const String astrick = ' *';
  static const String emptyString = '';

  // ---------- Login ----------
  /// Placeholder display name for the login greeting until a real signed-in
  /// user is wired in — a stand-in value, not translatable copy, so it lives
  /// here rather than in `l10n`.
  static const String loginPlaceholderUserName = 'Aya';

  /// Example placeholder shown in the email field — a sample address, not
  /// translatable copy, so it lives here rather than in `l10n`.
  static const String loginEmailPlaceholder = 'Brandonelouis@gmail.com';

  /// Masked placeholder shown in the password field.
  static const String loginPasswordPlaceholder = '************';

  // ---------- Home ----------
  /// Placeholder display name for the home tab's app-bar greeting until a
  /// real signed-in user is wired in — a stand-in value, not translatable
  /// copy, so it lives here rather than in `l10n`.
  static const String homePlaceholderUserName = 'Aya';
}
