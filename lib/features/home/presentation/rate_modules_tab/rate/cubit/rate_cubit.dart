// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../../../core/enums/rate_rating_filter.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../domain/entities/rate_entity.dart';
import '../../../../domain/usecases/get_rates_usecase.dart';
import 'rate_state.dart';

/// Drives the Rate tab. Loads the (currently dummy) pending ratings from
/// [GetRatesUseCase] as soon as it's created.
@injectable
class RateCubit extends Cubit<RateState> {
  RateCubit(this._getRatesUseCase, this._goRouter) : super(const RateState()) {
    _load();
  }

  final GetRatesUseCase _getRatesUseCase;
  final GoRouter _goRouter;

  Future<void> _load() async {
    final result = await _getRatesUseCase();
    if (isClosed) return;
    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (rates) => emit(state.copyWith(isLoading: false, rates: rates)),
    );
  }

  /// Switches the star-rating bucket highlighted in the tab row.
  void selectFilter(RateRatingFilter filter) =>
      emit(state.copyWith(selectedFilter: filter));

  /// Opens the rate-details screen for a tapped review card.
  ///
  /// The details screen pops with `true` after a successful delete — in that
  /// case the review is removed from the list locally (no refetch needed).
  Future<void> openRateDetails(RateEntity rate) async {
    final deleted = await _goRouter.pushNamed<bool>(
      AppRouteNames.rateDetails,
      extra: rate,
    );
    if (isClosed || deleted != true) return;
    emit(
      state.copyWith(
        rates: state.rates.where((r) => r.id != rate.id).toList(),
      ),
    );
  }
}
