import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';

/// One pill inside [InformationTabWidget]'s segmented bar.
///
/// The selected pill is white so it "lifts" off the grey track; the
/// unselected pill blends into the track. Tapping calls [onTap].
class InformationTabItemWidget extends StatelessWidget {
  const InformationTabItemWidget({
    required Key key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  /// Text shown inside the pill.
  final String label;

  /// Whether this pill is the currently selected tab.
  final bool isSelected;

  /// Called when the pill is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // Makes the whole pill tappable, including its transparent area when
      // unselected (otherwise only the text would receive taps).
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: isSelected ? AppColors.textWhite : AppColors.transparent,
        ),
        child: Center(
          child: AppText(
            text: label,
            style: AppTextStyles.bold12,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
