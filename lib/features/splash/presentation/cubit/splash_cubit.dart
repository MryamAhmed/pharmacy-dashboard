// Dart imports:
import 'dart:async';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmacy_app/shared/presentation/cubit/general_cubit.dart';

// Project imports:
import '../../../../core/router/app_routes.dart';
import 'splash_state.dart';

/// Drives the splash screen.
///
/// Holds a single 2-second [Timer] and, once it fires, routes to the login
/// screen. No session resolution — wire real auth-state checks in here
/// (skip straight to home when already signed in, etc.) once a backend
/// exists.
@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._goRouter, this.generalCubit) : super(const SplashState());

  final GoRouter _goRouter;
  final GeneralCubit generalCubit;
  Timer? _timer;

  void checkToken() async {
    final isTokenRestored = await generalCubit.restoreToken();
    if (isTokenRestored) {
      _navigateToHome();
    } else {
      _navigateToLogin();
    }
  }

  /// Starts the splash delay. Call once from the screen's `initState`.
  void start() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), checkToken);
  }

  void _navigateToLogin() {
    if (isClosed) return;
    _goRouter.goNamed(AppRouteNames.login);
  }

  void _navigateToHome() {
    if (isClosed) return;
    _goRouter.goNamed(AppRouteNames.home);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
