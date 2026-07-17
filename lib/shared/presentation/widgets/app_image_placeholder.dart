// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../core/themes/app_colors.dart';

/// Generic placeholder shown by [AppCachedImage] when it has no URL, or the
/// remote image fails to load.
///
/// Split into its own widget/file (rather than a private `_build...` method)
/// per PR guidelines.
class AppImagePlaceholder extends StatelessWidget {
  const AppImagePlaceholder({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      color: AppColors.containersGrayColor,
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: AppColors.hintTextGray,
      ),
    );
  }
}
