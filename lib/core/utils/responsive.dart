// Project imports:
import '../constants/app_values.dart';

/// Pure size → layout decision used by `ResponsiveLayout` and any screen that
/// needs to branch on the available width.
class Responsive {
  const Responsive._();

  /// Whether [width] (logical pixels) should render the web/desktop layout.
  static bool isWeb(double width) => width >= AppBreakpoints.web;
}
