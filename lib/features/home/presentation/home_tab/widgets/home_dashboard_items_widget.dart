import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/app_values.dart';
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../domain/entities/home_summary_entity.dart';
import 'home_dashboard_item_widget.dart';

class HomeDashboardItemsWidget extends StatelessWidget {
  const HomeDashboardItemsWidget({super.key, required this.homeSummaryEntity});
  final HomeSummaryEntity homeSummaryEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: HomeDashboardItemWidget(
                itemColor: AppColors.primaryColor,
                titleKey: TestKeys.homeDashboardTitle1,
                subTitle: context.l10n.homeDashboardUsersSubtitle,
                subTitleKey: TestKeys.homeDashboardSubTitle1,
                title: homeSummaryEntity.totalDoctors.toString(),
              ),
            ),
            const Gap(AppSpace.s12),
            Expanded(
              child: HomeDashboardItemWidget(
                itemColor: AppColors.dashboardItem2Color,
                titleKey: TestKeys.homeDashboardTitle2,
                subTitle: context.l10n.homeDashboardActiveJobsSubtitle,
                subTitleKey: TestKeys.homeDashboardSubTitle2,
                title: homeSummaryEntity.totalActiveJobs.toString(),
              ),
            ),
          ],
        ),
        const Gap(AppSpace.s8),
        Row(
          children: [
            Expanded(
              child: HomeDashboardItemWidget(
                itemColor: AppColors.dashboardItem3Color,
                titleKey: TestKeys.homeDashboardTitle3,
                subTitle: context.l10n.homeDashboardPharmaciesSubtitle,
                subTitleKey: TestKeys.homeDashboardSubTitle3,
                title: homeSummaryEntity.totalPharmacies.toString(),
              ),
            ),
            const Gap(AppSpace.s12),
            Expanded(
              child: HomeDashboardItemWidget(
                itemColor: AppColors.dashboardItem4Color,
                titleKey: TestKeys.homeDashboardTitle4,
                subTitle: context.l10n.homeDashboardApplicationsSubtitle,
                subTitleKey: TestKeys.homeDashboardSubTitle4,
                title: homeSummaryEntity.totalApplications.toString(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
