// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

/// Splash screen state.
///
/// The splash has no visual state of its own — it always shows the same
/// background + logo — so this is just a marker type. [SplashCubit] owns the
/// timing/navigation behaviour, not anything rendered from state.
@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState() = _SplashState;
}
