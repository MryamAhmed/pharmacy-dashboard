import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/core/constants/app_values.dart';
import 'package:pharmacy_app/core/themes/app_colors.dart';

import '../../../../../core/themes/app_text_style.dart';
import '../../../../../shared/presentation/widgets/app_text.dart';

class RecentActivityItemWidget extends StatelessWidget {
  final Widget icon;
  final String itemName;
  final String itemKey;
  final String duration;
  final String durationKey;
  const RecentActivityItemWidget({
    super.key,
    required this.icon,
    required this.itemKey,
    required this.itemName,
    required this.duration,
    required this.durationKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.textWhite,
      ),
      padding: const EdgeInsets.all(AppPaddings.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              const Gap(AppSpace.s20),
              AppText(
                key: Key(itemKey),
                text: itemName,
                style: AppTextStyles.regular12,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          AppText(
            key: Key(durationKey),
            text: duration,
            style: AppTextStyles.regular12HintColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
