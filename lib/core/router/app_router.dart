// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import '../../features/auth/presentation/login/cubit/login_cubit.dart';
import '../../features/auth/presentation/login/screens/login_screen.dart';
import '../../features/home/presentation/home_shell/screens/home_shell_screen.dart';
import '../../features/home/domain/entities/rate_entity.dart';
import '../../features/home/presentation/home_tab/cubit/home_tab_cubit.dart';
import '../../features/home/presentation/rate_modules/rate/cubit/rate_cubit.dart';
import '../../features/home/presentation/rate_modules/rate_details/presentation/rate_details/cubit/rate_details_cubit.dart';
import '../../features/home/presentation/rate_modules/rate_details/presentation/rate_details/screens/rate_details_screen.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../shared/presentation/cubit/general_cubit.dart';
import '../constants/test_keys.dart';
import '../di/di.dart';
import '../utils/platform_info.dart';
import 'app_routes.dart';

/// The app's single [GoRouter] instance.
///
/// The flow is intentionally minimal for this template: splash → login → home.
/// Wire real auth guards into [GoRouter.redirect] once a backend is connected.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  refreshListenable: getIt.get<GeneralCubit>(),
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: AppRouteNames.splash,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt.get<SplashCubit>(),
        child: const SplashScreen(key: Key(TestKeys.splashPage)),
      ),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: AppRouteNames.login,
      pageBuilder: (context, state) => appPage(
        key: state.pageKey,
        isFadeTransition: kIsWeb,
        child: BlocProvider(
          create: (_) => getIt.get<LoginCubit>(),
          child: const LoginScreen(key: Key(TestKeys.loginPage)),
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRouteNames.home,
      pageBuilder: (context, state) => appPage(
        key: state.pageKey,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt.get<HomeTabCubit>()),
            BlocProvider(create: (_) => getIt.get<RateCubit>()),
          ],
          child: const HomeShellScreen(key: Key(TestKeys.homeShellScaffold)),
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.rateDetails,
      name: AppRouteNames.rateDetails,
      pageBuilder: (context, state) => appPage(
        key: state.pageKey,
        child: BlocProvider(
          create: (_) => getIt.get<RateDetailsCubit>(
            param1: state.extra! as RateEntity,
          ),
          child: const RateDetailsScreen(key: Key(TestKeys.rateDetailsPage)),
        ),
      ),
    ),
  ],
);

/// Shared page builder providing a platform-appropriate transition.
CustomTransitionPage<T> appPage<T>({
  required LocalKey key,
  required Widget child,
  bool isFadeTransition = false,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      if (isFadeTransition || PlatformInfo.isWeb) {
        return FadeTransition(opacity: animation, child: child);
      }
      return CupertinoPageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: false,
        child: child,
      );
    },
  );
}
