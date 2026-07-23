// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../../core/constants/test_keys.dart';
import '../../../../../shared/presentation/widgets/app_scaffold.dart';
import '../../home_tab/screens/home_tab_screen.dart';
import '../../pharmacy_management/screens/pharmacy_management_screen.dart';
import '../../rate_modules/rate/screens/rate_screen.dart';
import '../../user_management/screens/user_management_screen.dart';
import '../widgets/home_bottom_nav_bar.dart';

/// Bottom-navigation shell for the home module.
///
/// Hosts the four tabs (Home, Pharmacy Management, Rate, User Management) in
/// an [IndexedStack] so switching tabs preserves each tab's scroll position
/// and state instead of rebuilding it from scratch.
///
/// [HomeTabCubit] and [RateCubit] are provided once by the `home` [GoRoute]
/// (see `app_router.dart`'s `MultiBlocProvider`), not per-tab here — both
/// tabs' `BlocBuilder`s simply resolve them from that ancestor context.
class HomeShellScreen extends StatefulWidget {
  const HomeShellScreen({required Key key}) : super(key: key);

  @override
  State<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends State<HomeShellScreen> {
  int _currentIndex = 0;

  // Built once — each tab keeps its own state across tab switches.
  late final List<Widget> _tabs = [
    const HomeTabScreen(key: Key(TestKeys.homeTabPage)),
    const PharmacyManagementScreen(key: Key(TestKeys.pharmacyManagementPage)),
    const UserManagementScreen(key: Key(TestKeys.userManagementPage)),
    const RateScreen(key: Key(TestKeys.ratePage)),
  ];

  void _onTabTapped(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.homeShellScaffold),
      mobileBody: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
