import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/features/home/domain/entities/rate_entity.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_text.dart';
import '../../../../rate/widgets/text_avatar_widget.dart';

class RateDetailsPharmacyCardWidget extends StatelessWidget {
  final RateEntity rate;
  const RateDetailsPharmacyCardWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            title: rate.pharmacyName.isEmpty
                ? ''
                : rate.pharmacyName[0].toUpperCase(),
          ),
          const Gap(AppSpace.s12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                key: const Key(TestKeys.rateDetailsPharmacyName),
                text: rate.pharmacyName,
                style: AppTextStyles.bold14,
              ),
              AppText(
                key: const Key(TestKeys.rateDetailsPharmacyAddress),
                text: 'Shoubra, Cairo · Verified',
                style: AppTextStyles.regular12Hintstyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
