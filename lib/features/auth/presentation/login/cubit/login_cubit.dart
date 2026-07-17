// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../../core/constants/app_error_codes.dart';
import '../../../../../core/extensions/go_router_navigation_x.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/utils/app_validations.dart';
import 'login_state.dart';

/// Drives the login form.
///
/// This is a UI stub: it validates the email/password inputs locally and, on
/// success, navigates to the home screen. Wire a real authentication use case
/// (data source → repository → use case) into [submit] when a backend exists.
@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._goRouter)
    : emailController = TextEditingController(),
      passwordController = TextEditingController(),
      super(const LoginState());

  final GoRouter _goRouter;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  void onEmailEdited() => emit(state.copyWith(emailFieldError: null));

  void onPasswordEdited() => emit(state.copyWith(passwordFieldError: null));

  void toggleObscurePassword() =>
      emit(state.copyWith(obscurePassword: !state.obscurePassword));

  /// Validates the form and, when valid, simulates a sign-in then routes home.
  ///
  /// Field errors are emitted as [AppErrorCodes] constants, not display
  /// strings — the screen resolves them to localized text via `context.l10n`
  /// since a Cubit has no `BuildContext`.
  Future<void> submit() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    final emailError = _validateEmail(email);
    final passwordError = _validatePassword(password);

    emit(
      state.copyWith(
        emailFieldError: emailError,
        passwordFieldError: passwordError,
      ),
    );

    if (emailError != null || passwordError != null) return;

    emit(state.copyWith(isSubmitting: true));

    // Simulated network latency — replace with a real auth call.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (isClosed) return;

    emit(state.copyWith(isSubmitting: false));
    // Drops login (and any prior auth screens) from history so the back
    // button can't return to them once signed in.
    _goRouter.clearStackAndGo(AppRouteNames.home);
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return AppErrorCodes.fieldRequired;
    if (!AppValidations.emailRegExp.hasMatch(email)) {
      return AppErrorCodes.invalidEmail;
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return AppErrorCodes.fieldRequired;
    return null;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
