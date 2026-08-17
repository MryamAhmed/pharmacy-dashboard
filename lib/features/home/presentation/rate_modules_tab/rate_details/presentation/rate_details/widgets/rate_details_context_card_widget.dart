import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_text.dart';

class RateDetailsContextCardWidget extends StatelessWidget {
  const RateDetailsContextCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          key: const Key(TestKeys.rateDetailsContextLabel),
          text: context.l10n.rateDetailsContextLabel,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                key: const Key(TestKeys.rateDetailsPostionContext),
                text:
                    '${context.l10n.rateDetailsPositionLabel}: Professional Pharmacist',
                style: AppTextStyles.regular12Hintstyle,
              ),
              AppText(
                key: const Key(TestKeys.rateDetailsShiftDateContext),
                text:
                    '${context.l10n.rateDetailsShiftDateLabel}: March 15, 2024',
                style: AppTextStyles.regular12Hintstyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
