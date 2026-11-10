// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// Project imports:
import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/enums/pharmacy_details_tab.dart';
import '../../../../../../core/extensions/app_error_localization.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_scaffold.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';
import '../cubit/pharmacy_datails_cubit.dart';
import '../cubit/pharmacy_details_states.dart';
import '../widgets/information_tab_widget.dart';
import '../widgets/owner_information_section_widget.dart';
import '../widgets/pharmacy_details_actions_widget.dart';
import '../widgets/pharmacy_info_title.dart';
import '../widgets/pharmacy_information_section_widget.dart';

/// Pharmacy details page: header, a "Pharmacy | Owner" tab bar, the section
/// for the selected tab, and Verify / Reject actions.
///
/// Every value shown comes from [PharmacyDetailsState.pharmacy] — the
/// pharmacy the user tapped, as returned by `GET Dashboard/pharmacies`.
class PharmacyDetailsScreen extends StatelessWidget {
  const PharmacyDetailsScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PharmacyDetailsCubit, PharmacyDetailsState>(
      // Show a SnackBar each time Verify/Reject fails.
      listenWhen: (previous, current) =>
          previous.error != current.error && current.error != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppText(
              text: state.error!.localized(context),
              style: AppTextStyles.medium14White,
            ),
          ),
        );
      },
      child: AppScaffold(
        key: const Key(TestKeys.pharmacyDetailsPage),
        backgroundColor: AppColors.screenBackground,
        showAppBar: true,
        appBarTitleStyle: AppTextStyles.bold16,
        showBackButton: true,
        mobileBody: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.p24,
            vertical: AppPaddings.p4,
          ),
          child: Column(
            children: [
              // The pharmacy never changes on this page, so the header is
              // built once and NOT inside the tab BlocBuilder — rebuilding it
              // on every tab tap re-decoded the large logo and froze taps.
              PharmacyInfoTitle(
                pharmacy: context.read<PharmacyDetailsCubit>().state.pharmacy,
              ),
              const Gap(AppSpace.s8),
              const InformationTabWidget(),
              const Gap(AppSpace.s24),
              // Only the section below the tabs swaps on a tab change.
              BlocBuilder<PharmacyDetailsCubit, PharmacyDetailsState>(
                buildWhen: (previous, current) =>
                    previous.selectedTab != current.selectedTab,
                builder: (context, state) =>
                    state.selectedTab == PharmacyDetailsTab.pharmacy
                    ? PharmacyInformationSectionWidget(pharmacy: state.pharmacy)
                    : OwnerInformationSectionWidget(pharmacy: state.pharmacy),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const PharmacyDetailsActionsWidget(),
      ),
    );
  }
}
