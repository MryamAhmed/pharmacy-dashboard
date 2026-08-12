// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_app/gen/assets.gen.dart';

// Project imports:
import '../../../../../core/constants/test_keys.dart';
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
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        key: const Key(TestKeys.homeBottomNavBar),
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.textWhite,
        items: [
          BottomNavigationBarItem(
            icon: Assets.images.icons.homeTabIcon.svg(
              height: 24.spMin,
              width: 24.spMin,
              color: AppColors.hintStyleColor,
            ),
            activeIcon: Container(
              height: 36.spMin,
              width: 36.spMin,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: Assets.images.icons.homeTabIcon.svg(
                  height: 24.spMin,
                  width: 24.spMin,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.images.icons.pharmacyTabIcon.svg(
              height: 24.spMin,
              width: 24.spMin,
              color: AppColors.hintStyleColor,
            ),
            activeIcon: Container(
              height: 36.spMin,
              width: 36.spMin,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: Assets.images.icons.pharmacyTabIcon.svg(
                  height: 24.spMin,
                  width: 24.spMin,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.images.icons.userTabIcon.svg(
              height: 24.spMin,
              width: 24.spMin,
              color: AppColors.hintStyleColor,
            ),
            activeIcon: Container(
              height: 36.spMin,
              width: 36.spMin,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: Assets.images.icons.userTabIcon.svg(
                  height: 24.spMin,
                  width: 24.spMin,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.images.icons.rateTabIcon.svg(
              height: 24.spMin,
              width: 24.spMin,
              color: AppColors.hintStyleColor,
            ),
            activeIcon: Container(
              height: 36.spMin,
              width: 36.spMin,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: Assets.images.icons.rateTabIcon.svg(
                  height: 24.spMin,
                  width: 24.spMin,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
