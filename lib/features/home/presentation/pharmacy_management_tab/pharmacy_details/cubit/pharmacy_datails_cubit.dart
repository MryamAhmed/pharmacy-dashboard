import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/features/home/presentation/pharmacy_management_tab/pharmacy_details/cubit/pharmacy_details_states.dart';

import '../../../../../../core/enums/pharmacy_details_tab.dart';

class PharmacyDetailsCubit extends Cubit<PharmacyDetailsState> {
  PharmacyDetailsCubit(super.initialState);

  void changeTab(PharmacyDetailsTab tab) =>
      emit(state.copyWith(selectedTab: tab));
}
