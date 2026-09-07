// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '../../../../../shared/domain/entities/app_error.dart';
import '../../../domain/entities/home_summary_entity.dart';

part 'home_tab_state.freezed.dart';

/// State for the Home tab — a single data class since it only ever
/// transitions loading → (greeting | error), never a distinct set of
/// screens.
@freezed
abstract class HomeTabState with _$HomeTabState {
  const factory HomeTabState({
    @Default(true) bool isLoading,
    HomeSummaryEntity homeSummaryEntity,

    /// Kept as the raw domain [AppError] (not a display string) — only the
    /// screen has a `BuildContext` to resolve it via `AppErrorX.localized()`.
    AppError? error,
  }) = _HomeTabState;
}
