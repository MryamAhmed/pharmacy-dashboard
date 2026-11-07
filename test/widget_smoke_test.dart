// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:pharmacy_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:pharmacy_app/features/splash/presentation/screens/splash_screen.dart';

import 'helpers/mocks/mock_cubits.dart';

void main() {
  testWidgets('Splash renders the background and logo', (tester) async {
    final goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SizedBox()),
        GoRoute(path: '/login', builder: (context, state) => const SizedBox()),
      ],
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 883),
        builder: (context, child) => MaterialApp(
          home: BlocProvider(
            // GeneralCubit is only used after the 2s timer, which this
            // first-frame test never reaches, so a bare mock is enough.
            create: (_) => SplashCubit(goRouter, MockGeneralCubit()),
            child: const SplashScreen(key: Key('splash')),
          ),
        ),
      ),
    );
    // First frame only — the splash schedules navigation after a 2s delay.
    await tester.pump();

    expect(find.byType(Image), findsNWidgets(2));
  });
}
