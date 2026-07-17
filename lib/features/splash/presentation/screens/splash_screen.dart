// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_app/gen/assets.gen.dart';

// Project imports:
import '../../../../core/constants/app_values.dart';
import '../../../../core/constants/test_keys.dart';
import '../../../../shared/presentation/widgets/app_scaffold.dart';
import '../cubit/splash_cubit.dart';

/// First screen shown on launch.
///
/// Renders the branded splash background with the app logo centered over it.
/// [SplashCubit] holds the 2-second delay and navigates to login once it
/// elapses — this widget only starts that timer and draws the UI.
class SplashScreen extends StatefulWidget {
  const SplashScreen({required Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().start();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.splashPage),
      // The background image fills the whole screen, including the status
      // bar area — the content itself doesn't need safe-area insets.
      safeArea: false,
      mobileBody: Stack(
        fit: StackFit.expand,
        children: [
          Assets.images.backgrounds.splashBackground.image(fit: BoxFit.cover),

          Center(
            child: Assets.images.logo.image(
              key: const Key(TestKeys.splashLogo),
              width: SplashDimens.logoWidth.w,
            ),
          ),
        ],
      ),
    );
  }
}
