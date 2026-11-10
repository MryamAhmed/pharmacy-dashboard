import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/enums/pharmacy_details_tab.dart';
import '../../../../../../shared/domain/entities/app_error.dart';
import '../../../../domain/entities/pharmacy_entity.dart';
import '../../../../domain/usecases/unverify_pharmacy_usecase.dart';
import '../../../../domain/usecases/verify_pharmacy_usecase.dart';
import 'pharmacy_details_states.dart';

/// Drives the pharmacy details screen: the Pharmacy/Owner tab bar and the
/// Verify / Reject buttons.
///
/// Created per navigation: the `pharmacyDetails` route builds it with the
/// tapped [PharmacyEntity] (route `extra` → injectable `@factoryParam`), so
/// each opened pharmacy gets its own cubit holding that pharmacy's data.
@injectable
class PharmacyDetailsCubit extends Cubit<PharmacyDetailsState> {
  PharmacyDetailsCubit(
    @factoryParam PharmacyEntity pharmacy,
    this._verifyPharmacyUseCase,
    this._unverifyPharmacyUseCase,
    this._goRouter,
  ) : super(PharmacyDetailsState(pharmacy: pharmacy));

  final VerifyPharmacyUseCase _verifyPharmacyUseCase;
  final UnverifyPharmacyUseCase _unverifyPharmacyUseCase;
  final GoRouter _goRouter;

  /// Switches the visible section to [tab].
  void changeTab(PharmacyDetailsTab tab) {
    // Tapping the already-selected tab is a no-op. Bloc only de-duplicates
    // equal states after its first emit, so guard explicitly.
    if (tab == state.selectedTab) return;
    emit(state.copyWith(selectedTab: tab));
  }

  /// Verify button → `Dashboard/verify`. On success pops with `true` so the
  /// list ([PharmacyCubit.openPharmacyDetails]) refetches.
  Future<void> verify() async {
    final id = state.pharmacy.id;
    // TEMP DEBUG: a null id means the tap returns without sending anything.
    debugPrint('[PharmacyDebug] details verify tapped: id=$id');
    if (state.isBusy || id == null) return;

    emit(state.copyWith(isVerifying: true, error: null));
    final result = await _verifyPharmacyUseCase(id);
    if (isClosed) return;

    result.fold(
      (error) {
        _logFailure('verify', error);
        emit(state.copyWith(isVerifying: false, error: error));
      },
      (_) {
        emit(state.copyWith(isVerifying: false));
        _goRouter.pop(true);
      },
    );
  }

  /// Reject button → `Dashboard/unverify`. Same flow as [verify].
  Future<void> reject() async {
    final id = state.pharmacy.id;
    // TEMP DEBUG: a null id means the tap returns without sending anything.
    debugPrint('[PharmacyDebug] details reject tapped: id=$id');
    if (state.isBusy || id == null) return;

    emit(state.copyWith(isRejecting: true, error: null));
    final result = await _unverifyPharmacyUseCase(id);
    if (isClosed) return;

    result.fold(
      (error) {
        _logFailure('reject', error);
        emit(state.copyWith(isRejecting: false, error: error));
      },
      (_) {
        emit(state.copyWith(isRejecting: false));
        _goRouter.pop(true);
      },
    );
  }

  // TEMP DEBUG: prints why a verify/reject request failed.
  void _logFailure(String action, AppError error) => debugPrint(
    '[PharmacyDebug] details $action FAILED: status=${error.statusCode} '
    'code=${error.code} message=${error.message}',
  );
}
