// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../core/constants/app_values.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_style.dart';
import 'app_text.dart';

/// A single tappable chip in [AppFilterTabsWidget].
///
/// Not built on [AppButtonWidget] — that widget bakes in a fixed 16sp label
/// and a full-width/default-height button, neither of which fits this
/// compact, small-text segmented-control chip.
class AppFilterTabChipWidget extends StatelessWidget {
  const AppFilterTabChipWidget({
    required Key key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppFilterTabsDimens.chipHeight.h,
        padding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.p12,
          vertical: AppPaddings.p8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppFilterTabsDimens.chipRadius.r),
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
