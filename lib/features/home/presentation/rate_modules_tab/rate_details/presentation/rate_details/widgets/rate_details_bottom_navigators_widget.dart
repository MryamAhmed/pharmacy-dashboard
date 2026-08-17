import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_button_widget.dart';

class RateDetailsBottomNavigatorsWidget extends StatelessWidget {
  const RateDetailsBottomNavigatorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.textWhite,
      padding: const EdgeInsets.fromLTRB(
        AppPaddings.p24,
        AppPaddings.p14,
        AppPaddings.p24,
        AppPaddings.p24,
      ),
      child: Row(
        children: [
          Expanded(
            child: AppButtonWidget(
              height: 50.h,
              radius: 8.r,
              key: const ValueKey('${TestKeys.rateDetailsButtonLabel}'),
              text: context.l10n.rateDetailsApproveButton,
              onPressed: () {
                context.pop();
              },
              backgroundColor: AppColors.dashboardItem2Color,
              style: AppTextStyles.bold12White,
            ),
          ),
          const Gap(AppSpace.s12),
          Expanded(
            child: AppButtonWidget(
              height: 50.h,
              radius: 8.r,
              key: const ValueKey('${TestKeys.rateDetailsButtonLabel}'),
              text: context.l10n.rateDetailsRejectButton,
              onPressed: () {
                context.pop();
              },
              backgroundColor: AppColors.rateRejectBackgroundColor,

              style: AppTextStyles.bold12RateRejectTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
