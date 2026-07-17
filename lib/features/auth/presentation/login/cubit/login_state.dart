// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

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

    /// Error **code** (see [AppErrorCodes]) for the email field, or null.
    /// Resolved to display text by the screen via `context.l10n`, since a
    /// Cubit has no `BuildContext` to localize with.
    String? emailFieldError,

    /// Error **code** for the password field, or null.
    String? passwordFieldError,
    @Default(false) bool isSubmitting,
  }) = _LoginState;
}
