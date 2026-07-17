// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_state.freezed.dart';

/// Global session state.
///
/// Holds the auth token, the selected app locale, and the selected theme
/// mode. A single data class (not a sealed union) — this is incrementally
/// updated session data, not a set of distinct loading/success/error screens.
@freezed
abstract class GeneralState with _$GeneralState {
  const factory GeneralState({
    /// The persisted JWT access token, or null when signed out.
    String? token,

    /// The active app locale. English is the default; Arabic is also
    /// supported.
    @Default(Locale('en')) Locale locale,

    /// The active theme mode (system / light / dark).
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _GeneralState;
}
