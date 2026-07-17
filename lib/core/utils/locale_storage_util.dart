// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../constants/local_storage_constant.dart';

/// Persists the user's UI preferences in [SharedPreferences].
///
/// Despite the name, this service holds both the active app locale and the
/// active [ThemeMode]. Both are lightweight, non-secret user preferences;
/// keeping them in one place avoids duplicating `SharedPreferences` access
/// across multiple tiny services.
class LocaleStorageUtil {
  // ---------- Locale ----------

  /// Returns the saved locale, or `null` if none has been saved yet.
  Future<Locale?> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(LocalStorageConstant.appLocale);
    if (code == null || code.isEmpty) {
      return null;
    }
    return Locale(code);
  }

  Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      LocalStorageConstant.appLocale,
      locale.languageCode,
    );
  }

  Future<void> clearLocale() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(LocalStorageConstant.appLocale);
  }

  // ---------- Theme ----------

  /// Returns the saved theme mode, or `null` if none has been saved yet.
  Future<ThemeMode?> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(LocalStorageConstant.appThemeMode);
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageConstant.appThemeMode, mode.name);
  }

  Future<void> clearThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(LocalStorageConstant.appThemeMode);
  }
}
