import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/enums/pharmacy_details_tab.dart';
import '../../../../domain/entities/pharmacy_entity.dart';

part 'pharmacy_details_states.freezed.dart';

/// State of the pharmacy details screen: the [pharmacy] that was tapped on
/// the pharmacy list, and the selected tab (pharmacy vs owner).
@freezed
abstract class PharmacyDetailsState with _$PharmacyDetailsState {
  const PharmacyDetailsState._();
  const factory PharmacyDetailsState({
    required PharmacyEntity pharmacy,
    @Default(PharmacyDetailsTab.pharmacy) PharmacyDetailsTab selectedTab,
  }) = _PharmacyDetailsState;
}
