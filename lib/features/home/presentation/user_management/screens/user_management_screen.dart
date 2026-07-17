// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../shared/presentation/widgets/app_coming_soon_view.dart';
import '../../../../../shared/presentation/widgets/app_scaffold.dart';

/// "User Management" bottom-nav tab.
///
/// Dummy placeholder — replace with the real user-management screen (staff
/// accounts, roles/permissions, etc.) once that feature is designed.
class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.userManagementPage),
      mobileBody: AppComingSoonView(
        icon: Icons.people_outline,
        title: context.l10n.userManagementTitle,
        subtitle: context.l10n.comingSoon,
      ),
    );
  }
}
