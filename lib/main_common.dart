// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_strategy/url_strategy.dart';

// Project imports:
import 'core/di/di.dart';
import 'core/router/app_router.dart';
import 'core/themes/main_theme.dart';
import 'core/utils/locale_storage_util.dart';
import 'core/utils/platform_info.dart';
import 'l10n/app_localizations.dart';
import 'shared/presentation/bloc_observer/simple_bloc_observer.dart';
import 'shared/presentation/cubit/general_cubit.dart';
import 'shared/presentation/cubit/general_state.dart';

/// Shared entrypoint invoked by every flavor's `main_*.dart`.
Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Lock the app to portrait by default.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (PlatformInfo.isWeb) {
    setPathUrlStrategy();
  }

  configureDependencies();

  // Restore persisted UI preferences before the first frame.
  final localeStorage = getIt.get<LocaleStorageUtil>();
  final cubit = getIt.get<GeneralCubit>();
  final savedLocale = await localeStorage.loadLocale();
  if (savedLocale != null) {
    await cubit.setLocale(savedLocale, persist: false);
  }
  final savedThemeMode = await localeStorage.loadThemeMode();
  if (savedThemeMode != null) {
    await cubit.setThemeMode(savedThemeMode, persist: false);
  }

  runApp(const MyApp());
}

/// Root widget: wires ScreenUtil, theming, localization, and the router.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Bloc.observer = MyBlocObserver();
    return ScreenUtilInit(
      designSize: const Size(402, 883),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider.value(
          value: getIt.get<GeneralCubit>(),
          child: BlocBuilder<GeneralCubit, GeneralState>(
            buildWhen: (previous, current) =>
                previous.locale != current.locale ||
                previous.themeMode != current.themeMode,
            builder: (context, state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context).appTitle,
                theme: MainTheme.lightTheme,
                darkTheme: MainTheme.darkTheme,
                themeMode: state.themeMode,
                routerConfig: appRouter,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: state.locale,
              );
            },
          ),
        );
      },
    );
  }
}
