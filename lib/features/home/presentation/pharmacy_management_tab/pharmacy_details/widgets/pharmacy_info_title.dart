import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_cached_image.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';
import '../../../../domain/entities/pharmacy_entity.dart';
import '../../../rate_modules_tab/rate/widgets/text_avatar_widget.dart';

/// Header of the pharmacy details screen: the pharmacy's logo (or its first
/// letter when there is no logo), name and address.
class PharmacyInfoTitle extends StatelessWidget {
  const PharmacyInfoTitle({super.key, required this.pharmacy});

  final PharmacyEntity pharmacy;

  @override
  Widget build(BuildContext context) {
    final name = pharmacy.pharmacyName ?? '';
    final logo = pharmacy.logo;
    return Column(
      children: [
        // The API may send no logo — fall back to a letter avatar.
        if (logo != null && logo.isNotEmpty)
          AppCachedImage(
            imageUrl: logo,
            width: 44.spMin,
            height: 44.spMin,
            borderRadius: BorderRadius.circular(22.r),
          )
        else
          TextAvatarWidget(
            size: 44.spMin,
            title: name.isEmpty ? '' : name[0].toUpperCase(),
          ),
        const Gap(AppSpace.s2),
        AppText(
          key: const ValueKey(TestKeys.pharmacyDetailsName),
          text: name,
          style: AppTextStyles.bold12,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSpace.s2),
        AppText(
          key: const ValueKey(TestKeys.pharmacyDetailsAddress),
          text: pharmacy.address ?? '',
          style: AppTextStyles.regular10Hintstyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
