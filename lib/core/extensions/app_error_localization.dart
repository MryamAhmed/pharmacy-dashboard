// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../shared/domain/entities/app_error.dart';
import '../constants/app_error_codes.dart';
import 'build_context_localizations.dart';

extension AppErrorX on AppError {
  /// Returns a user-facing localized message for this error.
  ///
  /// When you add a new error code in [AppErrorCodes], also add a case here
  /// (and the matching ARB key in `app_en.arb` / `app_ar.arb`).
  String localized(BuildContext context) {
    final l10n = context.l10n;

    switch (code) {
      case AppErrorCodes.fieldRequired:
        return l10n.validationFieldRequired;
      case AppErrorCodes.invalidEmail:
        return l10n.validationInvalidEmail;
      case AppErrorCodes.invalidCredentials:
        return l10n.errorInvalidCredentials;
      case AppErrorCodes.emailNotRegistered:
        return l10n.forgotPasswordEmailNotRegistered;
      case AppErrorCodes.emailAlreadyRegistered:
        return l10n.errorEmailAlreadyRegistered;
      case AppErrorCodes.passwordMismatch:
        return l10n.validationPasswordMismatch;
      case AppErrorCodes.socialSignInFailed:
        return l10n.errorSocialSignInFailed;
      // SOCIAL_SIGN_IN_CANCELLED is intentionally not mapped — the cubit
      // swallows it (user dismissed the sheet), so it never reaches the UI.
    }

    if (isNetwork) {
      return l10n.errorNetwork;
    }
    // Surface a backend-provided (already-localized) message when no
    // app-specific code or translation applies.
    final backendMessage = message;
    if (backendMessage != null && backendMessage.trim().isNotEmpty) {
      return backendMessage.trim();
    }
    return l10n.errorGeneric;
  }
}

/// Resolves a bare field-error **code** — as stored directly on a Cubit's
/// state (e.g. `LoginState.emailFieldError`) rather than wrapped in a full
/// [AppError] — to localized display text.
///
/// Returns `null` when there's no error, so callers can pass it straight
/// through to a field's `errorText`.
extension AppErrorCodeX on String? {
  String? fieldErrorText(BuildContext context) {
    final code = this;
    if (code == null) return null;
    return AppError.local(code).localized(context);
  }
}
