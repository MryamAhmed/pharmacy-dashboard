import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.textWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: AppPaddings.p32,
          left: AppPaddings.p8,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: AppText(
                key: const ValueKey('${TestKeys.pharmacyDetailsPhoneNumber}'),
                text: title,
                style: AppTextStyles.bold12,
              ),
            ),
            Expanded(
              flex: 2,
              child: AppText(
                key: const ValueKey(
                  '${TestKeys.pharmacyDetailsPhoneNumberValue}',
                ),
                text: value,
                style: AppTextStyles.bold12,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
