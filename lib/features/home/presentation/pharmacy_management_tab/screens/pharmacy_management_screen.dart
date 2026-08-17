// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../shared/presentation/widgets/app_coming_soon_view.dart';
import '../../../../../shared/presentation/widgets/app_scaffold.dart';

/// "Pharmacy Management" bottom-nav tab.
///
/// Dummy placeholder — replace with the real pharmacy-management dashboard
/// (inventory, orders, branches, etc.) once that feature is designed.
class PharmacyManagementScreen extends StatelessWidget {
  const PharmacyManagementScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.pharmacyManagementPage),
      mobileBody: AppComingSoonView(
        icon: Icons.local_pharmacy_outlined,
        title: context.l10n.pharmacyManagementTitle,
        subtitle: context.l10n.comingSoon,
      ),
    );
  }
}
