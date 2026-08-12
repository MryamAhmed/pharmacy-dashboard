import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/gen/assets.gen.dart';

import '../../../../../core/constants/app_values.dart';
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../../../../shared/presentation/widgets/app_text.dart';
import 'recent_activity_item_widget.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          key: const Key(TestKeys.homeQuickActions),
          text: context.l10n.recentActivityTitle,
          style: AppTextStyles.bold16,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSpace.s12),
        RecentActivityItemWidget(
          icon: Assets.images.icons.recentActivityDummy1Icon.svg(),
          itemKey: 'dummy1',
          itemName: 'El Ezaby posted Fresh Pharmacist',
          duration: '15m',
          durationKey: 'durationDummy1',
        ),
        const Gap(AppSpace.s8),
        RecentActivityItemWidget(
          icon: Assets.images.icons.recentActivityDummy2Icon.svg(),
          itemKey: 'dummy2',
          itemName: 'Al Nil Pharmacy registered',
          duration: '3h',
          durationKey: 'durationDummy2',
        ),
      ],
    );
  }
}
