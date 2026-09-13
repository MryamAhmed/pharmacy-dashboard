// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '../../../../../../core/enums/pharmacy_filter.dart';
import '../../../../../../shared/domain/entities/app_error.dart';
import '../../../../domain/entities/pharmacy_entity.dart';

part 'pharmacy_states.freezed.dart';

/// State for the Rate tab — a single data class since it only ever
/// transitions loading → (rates | error), never a distinct set of screens.
@freezed
abstract class PharmacyState with _$PharmacyState {
  const PharmacyState._();

  const factory PharmacyState({
    @Default(true) bool isLoading,
    @Default([]) List<PharmacyEntity> pharmacies,
    @Default(PharmacyFilter.all) PharmacyFilter selectedFilter,
    AppError? error,
  }) = _PharmacyState;

  List<PharmacyEntity> get filteredPharmacy =>
      pharmacies.where((r) => selectedFilter.matches(r.status ?? '')).toList();
}
