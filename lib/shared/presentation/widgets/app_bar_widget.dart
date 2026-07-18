// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import '../../../core/constants/app_values.dart';
import '../../../core/constants/test_keys.dart';
import '../../../core/themes/app_text_style.dart';
import '../../../gen/assets.gen.dart';
import 'app_text.dart';

/// Shared app bar.
///
/// Per PR guidelines: every screen's app bar must go through this widget
/// instead of a bare [AppBar].
///
/// Renders only a back icon (optional) and a title, laid out with a [Row]'s
/// default start alignment — [Directionality] flips that automatically, so
/// the group always sits at the leading edge (left in English/LTR, right in
/// Arabic/RTL) with no manual locale check needed.
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.titleStyle,
    this.showBackButton = true,
    this.onBackTap,
    this.backgroundColor,
  });

  /// The app bar title text.
  final String title;

  /// Style applied to [title]. Defaults to [AppTextStyles.bold18].
  final TextStyle? titleStyle;

  /// Whether the back icon is shown before the title.
  final bool showBackButton;

  /// Called when the back icon is tapped. Defaults to popping the current
  /// route via [GoRouter].
  final VoidCallback? onBackTap;

  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(AppBarWidgetDimens.height.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPaddings.p24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showBackButton) ...[
              GestureDetector(
                key: const Key(TestKeys.appBarBackButton),
                onTap: onBackTap ?? () => context.pop(),
                child: Assets.images.icons.backIcon.svg(
                  width: AppBarWidgetDimens.backIconSize.spMin,
                  height: AppBarWidgetDimens.backIconSize.spMin,
                ),
              ),
              const Gap(AppSpace.s8),
            ],
            Flexible(
              child: AppText(
                key: const Key(TestKeys.appBarTitle),
                text: title,
                style: titleStyle ?? AppTextStyles.bold18,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
