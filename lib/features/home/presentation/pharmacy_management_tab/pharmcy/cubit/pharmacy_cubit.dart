import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/enums/pharmacy_filter.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../../shared/domain/entities/app_error.dart';
import '../../../../domain/entities/pharmacy_entity.dart';
import '../../../../domain/usecases/pharmacy_use_case.dart';
import 'pharmacy_states.dart';

@injectable
class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyCubit(this._getPharmaciesUseCase, this._goRouter)
    : super(const PharmacyState()) {
    _load();
  }
  final PharmacyUseCase _getPharmaciesUseCase;
  final GoRouter _goRouter;

  Future<void> _load() async {
    try {
      final result = await _getPharmaciesUseCase.call();
      if (isClosed) return;
      result.fold(
        (error) => emit(state.copyWith(isLoading: false, error: error)),
        (pharmacies) =>
            emit(state.copyWith(isLoading: false, pharmacies: pharmacies)),
      );
    } catch (e) {
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

  void openPharmacyDetails(PharmacyEntity pharmacy) {
    _goRouter.pushNamed(AppRouteNames.rateDetails, extra: pharmacy);
  }
}
