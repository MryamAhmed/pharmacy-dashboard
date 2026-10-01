// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// Project imports:
import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_scaffold.dart';
import '../../../rate_modules_tab/rate_details/presentation/rate_details/widgets/rate_details_bottom_navigators_widget.dart';
import '../widgets/information_tab_widget.dart';
import '../widgets/information_widget.dart';
import '../widgets/pharmacy_document_widget.dart';
import '../widgets/pharmacy_info_title.dart';

class PharmacyDetailsScreen extends StatelessWidget {
  const PharmacyDetailsScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.pharmacyDetailsPage),
      backgroundColor: AppColors.screenBackground,
      showAppBar: true,
      appBarTitleStyle: AppTextStyles.bold16,
      showBackButton: true,
      mobileBody: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.p24,
            vertical: AppPaddings.p4,
          ),
          child: Column(
            children: [
              const PharmacyInfoTitle(),
              const Gap(AppSpace.s8),
              const InformationTabWidget(),
              const Gap(AppSpace.s24),
              const InformationWidget(title: 'Phone', value: '0111'),
              const InformationWidget(title: 'License Expiry', value: ''),
              const InformationWidget(title: 'License No.', value: ''),
              const InformationWidget(title: 'Industry', value: ''),
              const InformationWidget(title: 'Owner Name', value: ''),
              const InformationWidget(title: 'Website', value: ''),

              PharmacyDocumentWidget(
                name: context.l10n.pharmacyDetailsTaxCard,
                onViewPressed: () {},
              ),
            ],
          ),
        ),
      ),
      // Each button is wrapped in Expanded so the Row hands it a bounded
      // width; RateDetailsBottomNavigatorsWidget uses `width: double.infinity`,
      // which throws inside a Row's unbounded horizontal constraints.
      bottomNavigationBar: const Row(
        children: [
          Expanded(
            child: RateDetailsBottomNavigatorsWidget(
              backgroundColor: AppColors.dashboardItem2Color,
              rejectedColor: false,
            ),
          ),
          Expanded(
            child: RateDetailsBottomNavigatorsWidget(
              backgroundColor: AppColors.rateRejectBackgroundColor,
              rejectedColor: true,
            ),
          ),
        ],
      ),
    );
  }
}
