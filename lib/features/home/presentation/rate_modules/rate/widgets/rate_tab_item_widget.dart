import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_app/core/themes/app_colors.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/enums/rate_rating_filter.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';

/// A single tappable star-rating filter chip in the Rate tab's tab row.
///
/// Not built on [AppButtonWidget] — that widget bakes in a fixed 16sp label
/// and a full-width/default-height button, neither of which fits this
/// compact, small-text segmented-control chip.
class RateTabItemWidget extends StatelessWidget {
  final bool isSelected;
  final RateRatingFilter filter;
  final String title;
  final VoidCallback onTap;

  const RateTabItemWidget({
    super.key,
    required this.isSelected,
    required this.filter,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('${TestKeys.rateFilterTab}_${filter.name}'),
      onTap: onTap,
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.p12,
          vertical: AppPaddings.p8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: isSelected ? AppColors.primaryColor : AppColors.textWhite,
        ),
        child: Center(
          child: AppText(
            text: title,
            style: AppTextStyles.bold10White.copyWith(
              color: isSelected ? null : AppColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
