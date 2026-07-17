// Package imports:
import 'package:go_router/go_router.dart';

/// Navigation helpers on [GoRouter] shared across features.
extension GoRouterNavigationX on GoRouter {
  /// Removes every route from the stack and shows [name] as the only route,
  /// so the user cannot navigate back to the previous screens.
  ///
  /// Pops down to the single bottom-most route, then *replaces* it (a plain
  /// push would leave that bottom route behind). Used after auth success so the
  /// login/signup screens are dropped from history before showing the kids list.
  void clearStackAndGo(String name) {
    while (canPop()) {
      pop();
    }
    pushReplacementNamed(name);
  }
}
