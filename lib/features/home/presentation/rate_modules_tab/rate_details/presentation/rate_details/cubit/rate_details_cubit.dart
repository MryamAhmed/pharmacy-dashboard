// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../../../domain/entities/rate_entity.dart';
import '../../../../../../domain/usecases/delete_rate_usecase.dart';
import 'rate_details_state.dart';

/// Drives the rate-details screen. Holds the [RateEntity] the screen was
/// opened with (route `extra` → injectable `@factoryParam`) and performs the
/// Delete action.
@injectable
class RateDetailsCubit extends Cubit<RateDetailsState> {
  RateDetailsCubit(
    @factoryParam RateEntity rate,
    this._deleteRateUseCase,
    this._goRouter,
  ) : super(RateDetailsState(rate: rate));

  final DeleteRateUseCase _deleteRateUseCase;
  final GoRouter _goRouter;

  /// Deletes the current review. On success, pops back with `true` so the
  /// Rate list ([RateCubit.openRateDetails]) knows to drop it.
  Future<void> deleteRate() async {
    final id = state.rate.id;
    // Ignore double taps, and reviews without an id (nothing to delete).
    if (state.isDeleting || id == null) return;

    // Clear any previous error so a repeated failure still triggers the
    // screen's listener.
    emit(state.copyWith(isDeleting: true, error: null));
    final result = await _deleteRateUseCase(id);
    if (isClosed) return;

    result.fold(
      (error) => emit(state.copyWith(isDeleting: false, error: error)),
      (_) {
        emit(state.copyWith(isDeleting: false));
        _goRouter.pop(true);
      },
    );
  }
}
