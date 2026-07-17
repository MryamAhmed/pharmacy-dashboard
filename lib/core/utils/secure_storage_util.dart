// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../constants/secure_storage_constant.dart';

/// Wraps [FlutterSecureStorage] for token/credentials and similar secret data.
class SecureStorageUtil {
  SecureStorageUtil() {
    Future.microtask(_clearOnFirstRun);
  }

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(),
  );

  /// Secure storage survives app uninstall on iOS; clear it on first run after
  /// a fresh install so we don't reuse credentials from a previous install.
  Future<void> _clearOnFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool(SecureStorageConstant.firstRun) ?? true;
    if (isFirstRun) {
      await _storage.deleteAll();
      await prefs.setBool(SecureStorageConstant.firstRun, false);
    }
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> setJWTAccessToken(String? token) =>
      _storage.write(key: SecureStorageConstant.kJWTAccessToken, value: token);

  Future<String?> getJWTAccessToken() =>
      _storage.read(key: SecureStorageConstant.kJWTAccessToken);

  Future<void> deleteJWTAccessToken() =>
      _storage.delete(key: SecureStorageConstant.kJWTAccessToken);

  Future<void> setPassword(String? password) =>
      _storage.write(key: SecureStorageConstant.userPassword, value: password);

  Future<String?> getPassword() =>
      _storage.read(key: SecureStorageConstant.userPassword);

  Future<void> deletePassword() =>
      _storage.delete(key: SecureStorageConstant.userPassword);
}
