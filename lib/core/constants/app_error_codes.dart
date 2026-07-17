/// Backend/API string codes mapped in [AppErrorX.localized].
///
/// Per PR guidelines: every `AppError.local(...)` call and every
/// `error.code ==` comparison must use a constant from this class — never a
/// raw string literal.
class AppErrorCodes {
  const AppErrorCodes._();

  // Local validation (client-side)
  static const String fieldRequired = 'FIELD_REQUIRED';
  static const String invalidEmail = 'INVALID_EMAIL';

  // Auth
  static const String invalidCredentials = 'INVALID_CREDENTIALS';

  /// Returned by the forgot-password endpoint when the submitted email has no
  /// registered account.
  static const String emailNotRegistered = 'EMAIL_NOT_REGISTERED';

  static const String emailAlreadyRegistered = 'EMAIL_ALREADY_REGISTERED';
  static const String passwordMismatch = 'PASSWORD_MISMATCH';

  // Social auth (Google / Apple)
  /// The user dismissed the provider sheet before completing sign-in. The UI
  /// treats this as a silent no-op — no error message is shown.
  static const String socialSignInCancelled = 'SOCIAL_SIGN_IN_CANCELLED';

  /// The provider/Firebase sign-in failed for any other reason.
  static const String socialSignInFailed = 'SOCIAL_SIGN_IN_FAILED';
}
