import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_text.dart';
import '../../../../../../domain/entities/rate_entity.dart';

/// "Context" card: the reviewer's position from `GET Dashboard/reviews`.
/// The API has no shift date, so that row shows "-".
class RateDetailsContextCardWidget extends StatelessWidget {
  const RateDetailsContextCardWidget({super.key, required this.rate});

  final RateEntity rate;

  @override
  Widget build(BuildContext context) {
    final empty = context.l10n.pharmacyDetailsEmptyValue;
    final position = rate.reviewerPosition;
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
                    '${context.l10n.rateDetailsPositionLabel}: '
                    '${(position == null || position.isEmpty) ? empty : position}',
                style: AppTextStyles.regular12Hintstyle,
              ),
              AppText(
                key: const Key(TestKeys.rateDetailsShiftDateContext),
                text:
                    // Not in the reviews API.
                    '${context.l10n.rateDetailsShiftDateLabel}: $empty',
                style: AppTextStyles.regular12Hintstyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
