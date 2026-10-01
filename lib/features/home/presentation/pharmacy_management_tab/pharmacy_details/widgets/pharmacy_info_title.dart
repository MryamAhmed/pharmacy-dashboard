import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';
import '../../../rate_modules_tab/rate/widgets/text_avatar_widget.dart';

class PharmacyInfoTitle extends StatelessWidget {
  const PharmacyInfoTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextAvatarWidget(size: 44.spMin, title: 'A'),
        const Gap(AppSpace.s2),
        AppText(
          key: const ValueKey('${TestKeys.pharmacyDetailsName}'),
          text: "the Name of pharmacy",
          style: AppTextStyles.bold12,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSpace.s2),
        AppText(
          key: const ValueKey('${TestKeys.pharmacyDetailsAddress}'),
          text: "the Adress",
          style: AppTextStyles.regular10Hintstyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
