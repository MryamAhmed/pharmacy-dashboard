// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../../core/constants/app_values.dart';
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../core/themes/app_colors.dart';

/// Bottom navigation bar for [HomeShellScreen]'s four tabs.
///
/// Labels are kept short ("Home" / "Pharmacy" / "Rate" / "Users") so all four
/// fit on a single line at narrow widths — each tab's screen still shows its
/// full name ("Pharmacy Management" / "User Management") as its own title.
class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BottomNavigationBar(
      key: const Key(TestKeys.homeBottomNavBar),
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textGray,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.home_outlined,
            key: Key(TestKeys.homeNavHomeTab),
            size: HomeShellDimens.navIconSize,
          ),
          activeIcon: const Icon(
            Icons.home,
            size: HomeShellDimens.navIconSize,
          ),
          label: l10n.navHome,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.local_pharmacy_outlined,
            key: Key(TestKeys.homeNavPharmacyManagementTab),
            size: HomeShellDimens.navIconSize,
          ),
          activeIcon: const Icon(
            Icons.local_pharmacy,
            size: HomeShellDimens.navIconSize,
          ),
          label: l10n.navPharmacy,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.star_outline,
            key: Key(TestKeys.homeNavRateTab),
            size: HomeShellDimens.navIconSize,
          ),
          activeIcon: const Icon(
            Icons.star,
            size: HomeShellDimens.navIconSize,
          ),
          label: l10n.navRate,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.people_outline,
            key: Key(TestKeys.homeNavUserManagementTab),
            size: HomeShellDimens.navIconSize,
          ),
          activeIcon: const Icon(
            Icons.people,
            size: HomeShellDimens.navIconSize,
          ),
          label: l10n.navUsers,
        ),
      ],
    );
  }
}
