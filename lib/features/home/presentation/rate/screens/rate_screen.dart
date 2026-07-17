// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../shared/presentation/widgets/app_coming_soon_view.dart';
import '../../../../../shared/presentation/widgets/app_scaffold.dart';

/// "Rate" bottom-nav tab.
///
/// Dummy placeholder — replace with the real rating/review experience once
/// that feature is designed.
class RateScreen extends StatelessWidget {
  const RateScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.ratePage),
      mobileBody: AppComingSoonView(
        icon: Icons.star_outline,
        title: context.l10n.rateTitle,
        subtitle: context.l10n.comingSoon,
      ),
    );
  }
}
