// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/core/constants/app_values.dart';
import 'package:pharmacy_app/core/themes/app_colors.dart';
import 'package:pharmacy_app/core/themes/app_text_style.dart';

// Project imports:
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../shared/presentation/widgets/app_loading_widget.dart';
import '../../../../../shared/presentation/widgets/app_scaffold.dart';
import '../../../domain/entities/home_summary_entity.dart';
import '../cubit/home_tab_cubit.dart';
import '../cubit/home_tab_state.dart';
import '../widgets/home_dashboard_items_widget.dart';

/// "Home" bottom-nav tab.
///
/// Loads its greeting from [HomeTabCubit] (backed by the home module's own
/// data/domain layers — currently a dummy data source). The rest of the
/// dashboard is a placeholder until the real design lands.
class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.homeTabPage),
      backgroundColor: AppColors.screenBackground,
      showAppBar: true,
      appBarTitle: context.l10n.homeGreeting(
        AppConstants.homePlaceholderUserName,
      ),
      appBarTitleStyle: AppTextStyles.bold22,
      showBackButton: false,
      mobileBody: BlocBuilder<HomeTabCubit, HomeTabState>(
        builder: (context, state) {
          if (state.isLoading) return const AppLoadingWidget();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPaddings.p24),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeDashboardItemsWidget(
                    homeSummaryEntity:
                        state.homeSummaryEntity ??
                        const HomeSummaryEntity(
                          totalDoctors: 0,
                          totalPharmacies: 0,
                          totalActiveJobs: 0,
                          totalApplications: 0,
                          totalReviews: 0,
                        ),
                  ),
                  const Gap(AppSpace.s24),
                  //const QuickActionsWidget(),
                  //const Gap(AppSpace.s24),
                  //RecentActivityWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
