// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../core/utils/locale_storage_util.dart';
import '../../../core/utils/secure_storage_util.dart';
import '../../data/network/dio_client_service.dart';
import 'general_state.dart';

/// The only app-wide singleton Cubit. Holds session-scoped state (auth token,
/// locale, theme mode) and exposes coarse-grained session actions.
///
/// It mixes in [ChangeNotifier] so [GoRouter.refreshListenable] can rebuild the
/// route tree when the session changes. Feature Cubits should receive this via
/// their constructor rather than reaching for the service locator directly.
@lazySingleton
class GeneralCubit extends Cubit<GeneralState> with ChangeNotifier {
  GeneralCubit(
    this._dioClientService,
    this._secureStorageService,
    this._localeStorageService,
  ) : super(const GeneralState()) {
    // Own session-expiry globally: any 401 from any request logs the user out.
    _dioClientService.onUnauthorized = logout;
  }

  final DioClientService _dioClientService;
  final SecureStorageUtil _secureStorageService;
  final LocaleStorageUtil _localeStorageService;

  @override
  void emit(GeneralState state) {
    super.emit(state);
    notifyListeners();
  }

  /// Sets the auth token on the Dio client + session state and persists it.
  Future<void> setToken(String token) async {
    _dioClientService.setAuthToken(token);
    emit(state.copyWith(token: token));
    await _secureStorageService.setJWTAccessToken(token);
  }

  /// Clears the session: removes the token from Dio, state, and secure storage.
  Future<void> logout() async {
    _dioClientService.clearAuthToken();
    emit(state.copyWith(token: null));
    await _secureStorageService.deleteJWTAccessToken();
  }

  /// Updates the active locale, optionally persisting the choice.
  Future<void> setLocale(Locale locale, {bool persist = true}) async {
    emit(state.copyWith(locale: locale));
    if (persist) {
      await _localeStorageService.saveLocale(locale);
    }
  }

  /// Updates the active theme mode, optionally persisting the choice.
  Future<void> setThemeMode(ThemeMode mode, {bool persist = true}) async {
    emit(state.copyWith(themeMode: mode));
    if (persist) {
      await _localeStorageService.saveThemeMode(mode);
    }
  }
}
