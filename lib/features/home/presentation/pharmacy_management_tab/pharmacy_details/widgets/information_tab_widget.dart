import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/enums/pharmacy_details_tab.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../cubit/pharmacy_datails_cubit.dart';
import '../cubit/pharmacy_details_states.dart';
import 'information_tab_item_widget.dart';

/// Segmented "Pharmacy | Owner" tab bar on the pharmacy details screen.
///
/// Reads the selected tab from [PharmacyDetailsCubit] and forwards taps to
/// [PharmacyDetailsCubit.changeTab]; the screen swaps its body section in
/// response to the same state.
class InformationTabWidget extends StatelessWidget {
  const InformationTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacyDetailsCubit, PharmacyDetailsState>(
      // Only the selection affects this bar.
      buildWhen: (previous, current) =>
          previous.selectedTab != current.selectedTab,
      builder: (context, state) {
        final cubit = context.read<PharmacyDetailsCubit>();
        return Container(
          height: 36.h,
          padding: const EdgeInsets.symmetric(horizontal: AppPaddings.p4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.textLightGray,
          ),
          child: Row(
            children: [
              Expanded(
                child: InformationTabItemWidget(
                  key: const Key(TestKeys.pharmacyDetailsTab),
                  label: context.l10n.pharmacyDetailsPharmacyTab,
                  isSelected: state.selectedTab == PharmacyDetailsTab.pharmacy,
                  onTap: () => cubit.changeTab(PharmacyDetailsTab.pharmacy),
                ),
              ),
              const Gap(AppSpace.s4),
              Expanded(
                child: InformationTabItemWidget(
                  key: const Key(TestKeys.pharmacyDetailsOwnerTab),
                  label: context.l10n.pharmacyDetailsOwnerTab,
                  isSelected: state.selectedTab == PharmacyDetailsTab.owner,
                  onTap: () => cubit.changeTab(PharmacyDetailsTab.owner),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
