// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '../../../../../../core/enums/rate_rating_filter.dart';
import '../../../../../../shared/domain/entities/app_error.dart';
import '../../../../domain/entities/rate_entity.dart';

part 'rate_state.freezed.dart';

/// State for the Rate tab — a single data class since it only ever
/// transitions loading → (rates | error), never a distinct set of screens.
@freezed
abstract class RateState with _$RateState {
  const RateState._();

  const factory RateState({
    @Default(true) bool isLoading,
    @Default([]) List<RateEntity> rates,

    /// Which star-rating bucket the tab row currently highlights.
    @Default(RateRatingFilter.all) RateRatingFilter selectedFilter,

    /// Kept as the raw domain [AppError] (not a display string) — only the
    /// screen has a `BuildContext` to resolve it via `AppErrorX.localized()`.
    AppError? error,
  }) = _RateState;

  /// Reviews returned by the pending-reviews endpoint.
  List<RateEntity> get pendingRates => rates;

  /// [pendingRates] narrowed further by [selectedFilter].
  List<RateEntity> get filteredRates =>
      pendingRates.where((r) => selectedFilter.matches(r.rate ?? 0)).toList();

  /// How many [pendingRates] fall into [filter] — used for each tab's count.
  int countFor(RateRatingFilter filter) =>
      pendingRates.where((r) => filter.matches(r.rate ?? 0)).length;
}
