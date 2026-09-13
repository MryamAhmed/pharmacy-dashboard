import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/features/home/domain/entities/rate_entity.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_text.dart';

class RateGivenWidget extends StatelessWidget {
  final RateEntity rate;
  const RateGivenWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          key: const Key(TestKeys.rateDetailsRatingGivenLabel),
          text: context.l10n.rateDetailsRatingGivenLabel,
          style: AppTextStyles.medium12Hintstyle,
        ),
        const Gap(AppSpace.s4),

        AppText(
          key: const Key(TestKeys.rateDetailsStars),
          text: List.filled(rate.rate, '★').join(' '),
          style: AppTextStyles.regular28RateStarsColor,
        ),
      ],
    );
  }
}
