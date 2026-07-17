// Package imports:
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'di.config.dart';

final getIt = GetIt.instance;

/// Registers every dependency via `injectable`'s generated [getIt.init].
///
/// Every class that needs to be resolved from [getIt] carries its own
/// `@injectable` / `@lazySingleton` / `@LazySingleton(as: ...)` annotation
/// (see each class), plus [AppMainModule] for the handful of plain classes
/// that don't declare their own annotation. Run
/// `dart run build_runner build --delete-conflicting-outputs` after adding,
/// removing, or changing any of those annotations to regenerate `di.config.dart`.
@InjectableInit(preferRelativeImports: true)
void configureDependencies() => getIt.init();
