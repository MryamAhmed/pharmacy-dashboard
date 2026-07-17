// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../core/constants/app_values.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_style.dart';
import 'app_text.dart';

/// Shared primary action button.
///
/// Per PR guidelines: every button in the app must use this widget instead of
/// a bare [ElevatedButton] / [TextButton] / standalone [InkWell] — including
/// inside transient UI such as a `SnackBar`.
class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    required Key key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.radius,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  /// Shows a spinner in place of [text] while a submit/async action is
  /// running. The button is disabled whenever this is true.
  final bool isLoading;

  final bool isEnabled;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? radius;

  bool get _canPress => isEnabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final Color resolvedTextColor = textColor ?? AppColors.textWhite;

    return SizedBox(
      width: width ?? double.infinity,
      height: (height ?? AppButtonDimens.height).h,
      child: ElevatedButton(
        onPressed: _canPress ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          foregroundColor: resolvedTextColor,
          disabledBackgroundColor: AppColors.disabledButtonColor,
          disabledForegroundColor: AppColors.disabledButtonTextColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              (radius ?? AppButtonDimens.radius).r,
            ),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: AppButtonDimens.loaderSize.w,
                height: AppButtonDimens.loaderSize.h,
                child: CircularProgressIndicator(
                  strokeWidth: AppButtonDimens.loaderStrokeWidth,
                  color: resolvedTextColor,
                ),
              )
            : AppText(
                text: text,
                style: AppTextStyles.medium16White.copyWith(
                  color: resolvedTextColor,
                ),
                maxLines: 1,
              ),
      ),
    );
  }
}
