// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import '../../../core/constants/app_values.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_style.dart';
import 'app_text.dart';

/// Generic "not built yet" placeholder body — an icon, a title, and an
/// optional subtitle, centered on the screen.
///
/// Used by dummy/placeholder screens until their real content is
/// implemented, so every stub screen in the app looks consistent.
class AppComingSoonView extends StatelessWidget {
  const AppComingSoonView({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.s24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppSpace.s64, color: AppColors.primaryColor),
            const Gap(AppSpace.s16),
            AppText(
              text: title,
              style: AppTextStyles.bold20,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const Gap(AppSpace.s8),
              AppText(
                text: subtitle!,
                style: AppTextStyles.regular14Gray,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
