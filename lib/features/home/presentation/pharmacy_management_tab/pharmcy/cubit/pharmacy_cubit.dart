import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/enums/pharmacy_filter.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../../shared/domain/entities/app_error.dart';
import '../../../../domain/entities/pharmacy_entity.dart';
import '../../../../domain/usecases/pharmacy_use_case.dart';
import '../../../../domain/usecases/verify_pharmacy_usecase.dart';
import 'pharmacy_states.dart';

/// Drives the Pharmacy Management tab: loads the pharmacy list, filters it,
/// verifies a pharmacy from its card, and opens the details screen.
@injectable
class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyCubit(
    this._getPharmaciesUseCase,
    this._verifyPharmacyUseCase,
    this._goRouter,
  ) : super(const PharmacyState()) {
    _load();
  }

  final PharmacyUseCase _getPharmaciesUseCase;
  final VerifyPharmacyUseCase _verifyPharmacyUseCase;
  final GoRouter _goRouter;

  /// Fetches the list. Also used to refresh after verify/unverify — it does
  /// not set `isLoading`, so a refresh updates the list without a spinner.
  Future<void> _load() async {
    try {
      final result = await _getPharmaciesUseCase.call();
      if (isClosed) return;
      result.fold(
        (error) => emit(state.copyWith(isLoading: false, error: error)),
        (pharmacies) => emit(
          state.copyWith(isLoading: false, pharmacies: pharmacies, error: null),
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isLoading: false,
          error: AppError(message: e.toString()),
        ),
      );
    }
  }

  void selectFilter(PharmacyFilter filter) =>
      emit(state.copyWith(selectedFilter: filter));

  /// Verify button on a pharmacy card.
  Future<void> verifyPharmacy(PharmacyEntity pharmacy) async {
    final id = pharmacy.id;
    // TEMP DEBUG: a null id means the tap returns without sending anything.
    debugPrint(
      '[PharmacyDebug] card verify tapped: id=$id busy=${state.verifyingId}',
    );
    // One verify at a time, and nothing to send without an id.
    if (state.verifyingId != null || id == null) return;

    // Clear the previous error so a repeated failure still reaches the
    // screen's listener.
    emit(state.copyWith(verifyingId: id, actionError: null));
    final result = await _verifyPharmacyUseCase(id);
    if (isClosed) return;

    await result.fold(
      (error) async {
        debugPrint(
          '[PharmacyDebug] card verify FAILED: status=${error.statusCode} '
          'code=${error.code} message=${error.message}',
        );
        emit(state.copyWith(verifyingId: null, actionError: error));
      },
      // Refetch so the card shows the status the server now holds, then
      // clear the loader.
      (_) async {
        await _load();
        if (!isClosed) emit(state.copyWith(verifyingId: null));
      },
    );
  }

  /// Opens the details screen for a tapped card; the route creates a fresh
  /// [PharmacyDetailsCubit] from [pharmacy].
  ///
  /// The details screen pops with `true` after Verify/Reject succeeds, so the
  /// list is refetched to show the new status.
  Future<void> openPharmacyDetails(PharmacyEntity pharmacy) async {
    final changed = await _goRouter.pushNamed<bool>(
      AppRouteNames.pharmacyDetails,
      extra: pharmacy,
    );
    if (isClosed || changed != true) return;
    await _load();
  }
}
