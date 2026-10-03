import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/enums/pharmacy_details_tab.dart';
import 'pharmacy_details_states.dart';

/// Drives the pharmacy details screen's segmented tab bar
/// ([PharmacyDetailsTab.pharmacy] vs [PharmacyDetailsTab.owner]).
///
/// The screen reads [PharmacyDetailsState.selectedTab] to decide which
/// information section to render; this cubit only owns that selection.
@injectable
class PharmacyDetailsCubit extends Cubit<PharmacyDetailsState> {
  PharmacyDetailsCubit() : super(const PharmacyDetailsState());

  /// Switches the visible section to [tab].
  void changeTab(PharmacyDetailsTab tab) {
    // Tapping the already-selected tab is a no-op. Bloc only de-duplicates
    // equal states after its first emit, so guard explicitly.
    if (tab == state.selectedTab) return;
    emit(state.copyWith(selectedTab: tab));
  }
}
