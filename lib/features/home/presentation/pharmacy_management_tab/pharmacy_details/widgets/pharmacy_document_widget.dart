import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_button_widget.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';

/// A single uploaded-document row on the pharmacy details screen:
/// a file icon and the document [name] on the left, and a "View" button
/// on the right that triggers [onViewPressed].
class PharmacyDocumentWidget extends StatelessWidget {
  const PharmacyDocumentWidget({
    super.key,
    required this.name,
    this.onViewPressed,
  });

  /// Display name of the document (e.g. "Tax Card").
  final String name;

  /// Called when the "View" button is tapped.
  final VoidCallback? onViewPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key(TestKeys.pharmacyDetailsDocumentCard),
      height: 56.h,
      padding: const EdgeInsets.symmetric(horizontal: AppPaddings.p16),
      decoration: BoxDecoration(
        color: AppColors.textAvatarBackgroundColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.insert_drive_file,
            size: 22.spMin,
            color: AppColors.hintTextGray,
          ),
          const Gap(AppSpace.s8),
          // Expanded lets long names shrink/ellipsize instead of pushing
          // the "View" button off the card.
          Expanded(
            child: AppText(
              key: const Key(TestKeys.pharmacyDetailsDocumentName),
              text: name,
              style: AppTextStyles.regular16.copyWith(
                color: AppColors.textDarkGray,
              ),
              maxLines: 1,
            ),
          ),
          // AppButtonWidget defaults to full width, so it gets an explicit
          // width here; it must NOT be wrapped in Expanded.
          AppButtonWidget(
            key: const Key(TestKeys.pharmacyDetailsDocumentViewButton),
            text: context.l10n.pharmacyDetailsViewButton,
            onPressed: onViewPressed,
            width: 72.w,
            height: 36.h,
            radius: 10,
            style: AppTextStyles.bold16White,
          ),
        ],
      ),
    );
  }
}
