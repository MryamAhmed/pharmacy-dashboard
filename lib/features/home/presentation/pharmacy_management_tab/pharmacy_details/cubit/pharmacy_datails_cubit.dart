import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/enums/pharmacy_details_tab.dart';
import '../../../../domain/entities/pharmacy_entity.dart';
import 'pharmacy_details_states.dart';

/// Drives the pharmacy details screen's segmented tab bar
/// ([PharmacyDetailsTab.pharmacy] vs [PharmacyDetailsTab.owner]).
///
/// Created per navigation: the `pharmacyDetails` route builds it with the
/// tapped [PharmacyEntity] (route `extra` → injectable `@factoryParam`), so
/// each opened pharmacy gets a fresh cubit that is closed when the page pops.
///
/// The screen reads [PharmacyDetailsState.selectedTab] to decide which
/// information section to render.
@injectable
class PharmacyDetailsCubit extends Cubit<PharmacyDetailsState> {
  PharmacyDetailsCubit(@factoryParam PharmacyEntity pharmacy)
    : super(PharmacyDetailsState(pharmacy: pharmacy));

  /// Switches the visible section to [tab].
  void changeTab(PharmacyDetailsTab tab) {
    // Tapping the already-selected tab is a no-op. Bloc only de-duplicates
    // equal states after its first emit, so guard explicitly.
    if (tab == state.selectedTab) return;
    emit(state.copyWith(selectedTab: tab));
  }
}
