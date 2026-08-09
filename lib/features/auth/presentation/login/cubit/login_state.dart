// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '../../../../../shared/domain/entities/app_error.dart';

part 'login_state.freezed.dart';

/// Immutable state for the login screen.
///
/// A single data class (not a sealed union) since the login screen only ever
/// incrementally updates fields (field errors, obscure-password toggle,
/// submitting flag) rather than switching between distinct
/// loading/success/error screens.
@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(true) bool obscurePassword,
    @Default(false) bool rememberMe,

    /// Error **code** (see [AppErrorCodes]) for the email field, or null.
    /// Resolved to display text by the screen via `AppErrorCodeX.fieldErrorText`
    /// (`core/extensions/app_error_localization.dart`), since a Cubit has no
    /// `BuildContext` to localize with.
    String? emailFieldError,

    /// Error **code** for the password field, or null.
    String? passwordFieldError,

    /// General (non-field) submit failure — e.g. a network error while
    /// signing in. Kept as the raw domain [AppError] (not a display string),
    /// matching [HomeTabState]: only the screen has a `BuildContext` to
    /// resolve it via `AppErrorX.resolveMessage()`.
    AppError? error,
    @Default(false) bool isSubmitting,
  }) = _LoginState;
}
