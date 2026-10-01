import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/enums/pharmacy_details_tab.dart';

part 'pharmacy_details_states.freezed.dart';

/// Selected pharmacy-details tab (pharmacy vs owner).
@freezed
abstract class PharmacyDetailsState with _$PharmacyDetailsState {
  const PharmacyDetailsState._();
  const factory PharmacyDetailsState({
    @Default(PharmacyDetailsTab.pharmacy) PharmacyDetailsTab selectedTab,
  }) = _PharmacyDetailsState;
}
