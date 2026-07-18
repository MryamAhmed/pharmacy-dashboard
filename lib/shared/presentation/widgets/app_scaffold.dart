// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../core/constants/test_keys.dart';
import '../../../core/extensions/build_context_localizations.dart';
import '../../../core/utils/responsive.dart';
import 'app_bar_widget.dart';

/// Shared screen root.
///
/// Per PR guidelines: every screen must build on top of this instead of a
/// bare [Scaffold].
///
/// Provides a single, minimal responsive switch (via [Responsive.isWeb]):
/// [mobileBody] renders below the web breakpoint and [webBody] (when
/// supplied) renders at/above it — mirroring the pattern already covered by
/// [TestKeys.responsiveMobile] / [TestKeys.responsiveWeb]. The app bar is
/// built from [showAppBar]/[appBarTitle]/... via the shared [AppBarWidget] —
/// screens never build their own [AppBar]. Everything else (background,
/// bottom navigation, FAB) is passed straight through to the underlying
/// [Scaffold] so feature screens stay in control of their own chrome.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required Key key,
    required this.mobileBody,
    this.webBody,
    this.showAppBar = false,
    this.appBarTitle,
    this.appBarTitleStyle,
    this.showBackButton = true,
    this.onBackTap,
    this.appBarBackgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.safeArea = true,
  }) : super(key: key);

  /// Body shown below the web breakpoint ([Responsive.isWeb]).
  final Widget mobileBody;

  /// Body shown at/above the web breakpoint. Falls back to [mobileBody] when
  /// omitted, so screens that haven't built a web layout yet still work.
  final Widget? webBody;

  /// Whether to render the shared [AppBarWidget] at all.
  final bool showAppBar;

  /// Title forwarded to [AppBarWidget.title]. Required when [showAppBar] is
  /// true.
  final String? appBarTitle;

  /// Forwarded to [AppBarWidget.titleStyle].
  final TextStyle? appBarTitleStyle;

  /// Forwarded to [AppBarWidget.showBackButton].
  final bool showBackButton;

  /// Forwarded to [AppBarWidget.onBackTap].
  final VoidCallback? onBackTap;

  /// Forwarded to [AppBarWidget.backgroundColor].
  final Color? appBarBackgroundColor;

  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;

  /// Whether to wrap the body in a [SafeArea]. Screens that manage their own
  /// insets (e.g. a full-bleed background image) can set this to `false`.
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    final isWeb = Responsive.isWeb(context.screenWidth);

    final Widget body = isWeb && webBody != null
        ? KeyedSubtree(key: const Key(TestKeys.responsiveWeb), child: webBody!)
        : KeyedSubtree(
            key: const Key(TestKeys.responsiveMobile),
            child: mobileBody,
          );

    final PreferredSizeWidget? resolvedAppBar = showAppBar
        ? AppBarWidget(
            key: const Key(TestKeys.appBarWidget),
            title: appBarTitle ?? '',
            titleStyle: appBarTitleStyle,
            showBackButton: showBackButton,
            onBackTap: onBackTap,
            backgroundColor: appBarBackgroundColor,
          )
        : null;

    return Scaffold(
      key: key,
      backgroundColor: backgroundColor,
      appBar: resolvedAppBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: safeArea ? SafeArea(child: body) : body,
    );
  }
}
