import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/features/home/domain/entities/rate_entity.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_text.dart';

class RateDetailsRateTextCardWidget extends StatelessWidget {
  final RateEntity rate;
  const RateDetailsRateTextCardWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          key: const Key(TestKeys.rateDetailsRatingTextLabel),
          text: context.l10n.rateDetailsReviewTextLabel,
          style: AppTextStyles.medium12Hintstyle,
        ),
        const Gap(AppSpace.s4),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.textWhite,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: const EdgeInsets.all(AppPaddings.p12),
          child: AppText(
            key: const Key(TestKeys.rateDetailsDescription),
            text: rate.reviewText,
            style: AppTextStyles.regular12,
          ),
        ),
      ],
    );
  }
}
