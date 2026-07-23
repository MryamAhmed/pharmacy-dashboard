import 'package:flutter/widgets.dart';

import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_text.dart';

class RateDetailsPreviousRateWidget extends StatelessWidget {
  const RateDetailsPreviousRateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppText(
      key: const Key(TestKeys.rateDetailsPreviousRate),
      text:
          'Ahmed${context.l10n.rateDetailsPreviousRatingsLabel} 4.8, 4.7, 5.0, 4.9',
      style: AppTextStyles.regular12Hintstyle,
    );
  }
}
