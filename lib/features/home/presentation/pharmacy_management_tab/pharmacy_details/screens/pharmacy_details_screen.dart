// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_scaffold.dart';

class PharmacyDetailsScreen extends StatelessWidget {
  const PharmacyDetailsScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.homeTabPage),
      backgroundColor: AppColors.screenBackground,
      showAppBar: true,
      appBarTitle: context.l10n.pharmacyManagementTitle,
      appBarTitleStyle: AppTextStyles.bold16,
      showBackButton: false,
      mobileBody: Container(),
    );
  }
}
