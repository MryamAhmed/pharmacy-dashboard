import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/features/home/domain/entities/rate_entity.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_cached_image.dart';
import '../../../../../../../../shared/presentation/widgets/app_text.dart';
import '../../../../rate/widgets/text_avatar_widget.dart';

/// Card for whoever wrote the review (the reviewer): their profile picture
/// (or first letter) and name, from `GET Dashboard/reviews`.
class RateDetailsPharmacyCardWidget extends StatelessWidget {
  final RateEntity rate;
  const RateDetailsPharmacyCardWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    final name = rate.reviewerName ?? '';
    final picture = rate.profilePicture;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: const EdgeInsets.all(AppPaddings.p12),
      child: Row(
        children: [
          // Real picture when the API sends one, else the first letter.
          if (picture != null && picture.isNotEmpty)
            AppCachedImage(
              imageUrl: picture,
              width: 44.spMin,
              height: 44.spMin,
              borderRadius: BorderRadius.circular(22.r),
            )
          else
            TextAvatarWidget(
              size: 44.spMin,
              style: AppTextStyles.bold16PrimaryColor,
              title: name.isEmpty ? '' : name[0].toUpperCase(),
            ),
          const Gap(AppSpace.s12),
          // Expanded so a long name wraps/ellipsizes instead of overflowing.
          Expanded(
            child: AppText(
              key: const Key(TestKeys.rateDetailsPharmacyName),
              text: name,
              style: AppTextStyles.bold14,
            ),
          ),
        ],
      ),
    );
  }
}
