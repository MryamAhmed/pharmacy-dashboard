// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import '../../l10n/app_localizations.dart';

extension BuildContextLocalizations on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get viewInsetsBottom => MediaQuery.viewInsetsOf(this).bottom;

  double get viewPaddingBottom => MediaQuery.paddingOf(this).bottom;

  double get viewPaddingTop => MediaQuery.paddingOf(this).top;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
}
