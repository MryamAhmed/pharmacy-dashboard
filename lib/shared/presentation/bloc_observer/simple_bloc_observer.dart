// Dart imports:
import 'dart:developer' as developer;

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../flavors.dart';

/// Logs Cubit/Bloc transitions to the developer console.
///
/// Only logs in non-prod flavors to avoid leaking state in production builds.
class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (Flavor.enableNetworkLogger) {
      developer.log('${bloc.runtimeType}: $change', name: 'BlocObserver');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (Flavor.enableNetworkLogger) {
      developer.log(
        '${bloc.runtimeType} error',
        name: 'BlocObserver',
        error: error,
        stackTrace: stackTrace,
      );
    }
    super.onError(bloc, error, stackTrace);
  }
}
