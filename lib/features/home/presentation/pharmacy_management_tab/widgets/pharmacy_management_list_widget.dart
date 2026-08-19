import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/features/home/presentation/pharmacy_management_tab/widgets/filters_tab_widget.dart';

import 'package:pharmacy_app/features/home/presentation/pharmacy_management_tab/widgets/pharmacy_card_widget.dart';
import 'package:pharmacy_app/features/home/presentation/pharmacy_management_tab/widgets/search_bar_widget.dart';

import '../../../../../core/constants/app_values.dart';
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../../../../shared/presentation/widgets/app_text.dart';

class PharmacyManagementListWidget extends StatelessWidget {
  const PharmacyManagementListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          key: const Key(TestKeys.numberOfRegistered),
          text: "89 registered",
          style: AppTextStyles.regular12Hintstyle,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSpace.s12),
        const FiltersTap(),
        const Gap(AppSpace.s12),
        const SearchBarWidget(),
        const Gap(AppSpace.s12),
        const PharmacyCardWidget(),
      ],
    );
  }
}
