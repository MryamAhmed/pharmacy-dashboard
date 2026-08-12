import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/app_values.dart';
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../../../../shared/presentation/widgets/app_text.dart';
import 'quick_actions_item_widget.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          key: const Key(TestKeys.homeQuickActions),
          text: context.l10n.quickActionsTitle,
          style: AppTextStyles.bold16,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSpace.s12),
        Row(
          children: [
            Expanded(
              child: QuickActionsItemWidget(
                itemColor: AppColors.primaryColor,
                itemKey: TestKeys.approveRating,
                itemName: context.l10n.quickActionApproveRating,
              ),
            ),
            const Gap(AppSpace.s12),

            Expanded(
              child: QuickActionsItemWidget(
                itemColor: AppColors.dashboardItem3Color,
                itemKey: TestKeys.approveRating,
                itemName: context.l10n.quickActionVerifyUsers,
              ),
            ),
            const Gap(AppSpace.s12),

            Expanded(
              child: QuickActionsItemWidget(
                itemColor: AppColors.dashboardItem4Color,
                itemKey: TestKeys.approveRating,
                itemName: context.l10n.quickActionVerifyPharmacies,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
