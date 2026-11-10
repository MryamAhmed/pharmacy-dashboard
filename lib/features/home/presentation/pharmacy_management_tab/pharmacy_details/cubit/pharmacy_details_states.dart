import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/enums/pharmacy_details_tab.dart';
import '../../../../../../shared/domain/entities/app_error.dart';
import '../../../../domain/entities/pharmacy_entity.dart';

part 'pharmacy_details_states.freezed.dart';

/// State of the pharmacy details screen: the [pharmacy] tapped on the list
/// (from `GET Dashboard/pharmacies`), the selected tab, and the status of the
/// Verify / Reject actions.
@freezed
abstract class PharmacyDetailsState with _$PharmacyDetailsState {
  const PharmacyDetailsState._();
  const factory PharmacyDetailsState({
    required PharmacyEntity pharmacy,
    @Default(PharmacyDetailsTab.pharmacy) PharmacyDetailsTab selectedTab,

    /// True while `Dashboard/verify` is in flight (Verify shows a loader).
    @Default(false) bool isVerifying,

    /// True while `Dashboard/unverify` is in flight (Reject shows a loader).
    @Default(false) bool isRejecting,

    /// Set when Verify/Reject fails — shown in a SnackBar.
    AppError? error,
  }) = _PharmacyDetailsState;

  /// Either action running → both buttons are disabled.
  bool get isBusy => isVerifying || isRejecting;
}
