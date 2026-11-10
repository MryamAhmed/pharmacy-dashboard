// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '../../../../../../core/enums/pharmacy_filter.dart';
import '../../../../../../shared/domain/entities/app_error.dart';
import '../../../../domain/entities/pharmacy_entity.dart';

part 'pharmacy_states.freezed.dart';

/// State for the Pharmacy Management tab: the pharmacy list, the selected
/// filter, and the status of a card's Verify action.
@freezed
abstract class PharmacyState with _$PharmacyState {
  const PharmacyState._();

  const factory PharmacyState({
    @Default(true) bool isLoading,
    @Default([]) List<PharmacyEntity> pharmacies,
    @Default(PharmacyFilter.all) PharmacyFilter selectedFilter,

    /// Error from loading the list.
    AppError? error,

    /// Id of the pharmacy whose Verify request is in flight — only that
    /// card's button shows a loader.
    String? verifyingId,

    /// Error from a Verify tap — shown in a SnackBar, kept separate from
    /// [error] so a failed verify doesn't replace the whole list.
    AppError? actionError,
  }) = _PharmacyState;

  List<PharmacyEntity> get filteredPharmacy =>
      pharmacies.where((r) => selectedFilter.matches(r.status ?? '')).toList();
}
