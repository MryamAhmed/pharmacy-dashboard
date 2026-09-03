// Package imports:
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../domain/usecases/get_home_summary_usecase.dart';
import 'home_tab_state.dart';

/// Drives the Home tab. Loads the (currently dummy) dashboard summary from
/// [GetHomeSummaryUseCase] as soon as it's created.
@injectable
class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit(this._getHomeSummaryUseCase) : super(const HomeTabState()) {
    _load();
  }

  final GetHomeSummaryUseCase _getHomeSummaryUseCase;

  Future<void> _load() async {
    log("message _load");
    final result = await _getHomeSummaryUseCase();
    if (isClosed) return;
    result.fold(
      (error) {
         emit(state.copyWith(isLoading: false, error: error));
         log("message error: $error");
         },
      (summary) {
          log("message summary1111: $summary");

          emit(state.copyWith(isLoading: false, homeSummaryEntity: summary));
          log("message summary: $summary");
        }
    );
  }
}
