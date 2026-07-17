// Package imports:
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../shared/data/network/dio_client_service.dart';
import '../router/app_router.dart';
import '../utils/locale_storage_util.dart';
import '../utils/secure_storage_util.dart';
import '../utils/url_launcher_util.dart';

/// Registers core infrastructure singletons that are plain classes with no
/// `@injectable`/`@lazySingleton` annotation of their own (kept framework-free
/// where possible) plus the app's single [GoRouter] instance.
@module
abstract class AppMainModule {
  @lazySingleton
  DioClientService get dioClientService => DioClientService();

  @lazySingleton
  SecureStorageUtil get secureStorageUtil => SecureStorageUtil();

  @lazySingleton
  LocaleStorageUtil get localeStorageUtil => LocaleStorageUtil();

  @lazySingleton
  UrlLauncherUtil get urlLauncherUtil => UrlLauncherUtil();

  /// The router depends on [GeneralCubit] as its `refreshListenable` — since
  /// `GeneralCubit` is itself `@lazySingleton`, injectable resolves it before
  /// this getter runs.
  @lazySingleton
  GoRouter get goRouter => appRouter;
}
