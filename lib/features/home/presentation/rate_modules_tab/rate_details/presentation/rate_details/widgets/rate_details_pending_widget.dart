import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_app/features/home/domain/entities/rate_entity.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/extensions/date_time_x.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_text.dart';

class RateDetailsPendingWidget extends StatelessWidget {
  final RateEntity rate;
  const RateDetailsPendingWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.ratePendingBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPaddings.p12,
        vertical: AppPaddings.p8,
      ),
      child: AppText(
        key: const Key(TestKeys.rateDetailsDate),
        text: context.l10n.rateDetailsPendingApproval(
          rate.dateTime.relativeTime(context),
        ),
        style: AppTextStyles.regular12DashboardItem3Color,
      ),
    );
  }
}
