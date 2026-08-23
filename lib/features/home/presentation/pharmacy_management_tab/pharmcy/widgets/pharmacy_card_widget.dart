// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// Project imports:
import '../../../../../../../core/constants/app_values.dart';
import '../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../shared/presentation/widgets/app_button_widget.dart';
import '../../../../../../../shared/presentation/widgets/app_text.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../rate_modules_tab/rate/widgets/text_avatar_widget.dart'
    show TextAvatarWidget;

class PharmacyCardWidget extends StatelessWidget {
  const PharmacyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ValueKey(TestKeys.pharmacyCardItem),
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppPaddings.p12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.textWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const TextAvatarWidget(title: "b"),
                  const Gap(AppSpace.s12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: AppText(
                                key: const ValueKey(TestKeys.pharmacyName),
                                text: "Al Nil Pharmacy",
                                style: AppTextStyles.bold12,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: AppButtonWidget(
                                height: 28.h,
                                width: 44.w,
                                radius: 11.r,
                                key: const ValueKey(TestKeys.pharmacyVerified),
                                text: "Verified",
                                onPressed: () {},
                                style: AppTextStyles.bold16PrimaryColor,
                                backgroundColor: AppColors.disabledButtonColor,
                              ),
                            ),
                          ],
                        ),
                        AppText(
                          key: const ValueKey(TestKeys.pharmacyLocation),
                          text: "Rod El Farag",
                          style: AppTextStyles.regular10Hintstyle,
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: AppText(
                                key: const ValueKey(TestKeys.pharmacyOwner),
                                text: "Owner: Hassan Mahmoud",
                                style: AppTextStyles.regular10Hintstyle,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: AppText(
                                key: const ValueKey(TestKeys.pharmacyTime),
                                text: "2h ago",
                                style: AppTextStyles.regular10Hintstyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Gap(AppSpace.s12),
          ],
        ),
      ),
    );
  }
}
