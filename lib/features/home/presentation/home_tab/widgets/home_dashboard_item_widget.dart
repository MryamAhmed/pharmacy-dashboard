import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/app_values.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../../../../shared/presentation/widgets/app_text.dart';

class HomeDashboardItemWidget extends StatelessWidget {
  final Color itemColor;
  final String title;
  final String titleKey;
  final String subTitle;
  final String subTitleKey;
  const HomeDashboardItemWidget({
    super.key,
    required this.itemColor,
    required this.titleKey,
    required this.subTitle,
    required this.subTitleKey,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 72.h,
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(height: 75.h, width: 4, color: itemColor),
          const Gap(AppSpace.s10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                key: Key(titleKey),
                text: title,
                style: AppTextStyles.bold22.copyWith(color: itemColor),
                textAlign: TextAlign.center,
              ),
              const Gap(AppSpace.s4),
              AppText(
                key: Key(subTitleKey),
                text: subTitle,
                style: AppTextStyles.regular12HintColor,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
