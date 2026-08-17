import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/features/home/domain/entities/rate_entity.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/extensions/string_x.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_text.dart';
import '../../../../rate/widgets/text_avatar_widget.dart';

class RateDetailsUserCardWidget extends StatelessWidget {
  final RateEntity rate;
  const RateDetailsUserCardWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          key: const Key(TestKeys.rateDetailsRateLabel),
          text: context.l10n.rateDetailsRatingForLabel,
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
          child: Row(
            children: [
              TextAvatarWidget(
                size: 44.spMin,
                style: AppTextStyles.bold16PrimaryColor,
                title: rate.userName.initials,
              ),
              const Gap(AppSpace.s12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    key: const Key(TestKeys.rateDetailsUserName),
                    text: rate.userName,
                    style: AppTextStyles.bold14,
                  ),
                  AppText(
                    key: const Key(TestKeys.rateDetailsUserAddress),
                    text: '3 Years Exp · Shoubra',
                    style: AppTextStyles.regular12Hintstyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
