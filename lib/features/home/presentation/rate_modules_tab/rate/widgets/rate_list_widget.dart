// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// Project imports:
import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';
import '../cubit/rate_state.dart';
import 'rate_card_widget.dart';
import 'rate_tabs_widget.dart';

/// Owns the whole Rate tab body once data has loaded: the pending-count
/// summary, the star-rating filter tabs, and the (filtered) list of review
/// cards. [RateScreen] just switches between this and a loading indicator.
class RateListWidget extends StatelessWidget {
  const RateListWidget({super.key, required this.state});

  final RateState state;

  @override
  Widget build(BuildContext context) {
    final filteredRates = state.filteredRates;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          key: const Key(TestKeys.numberOfPending),
          text: context.l10n.rateReviewsWaitingForApproval(
            state.pendingRates.length,
          ),
          style: AppTextStyles.regular12Hintstyle,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSpace.s12),
        RateTabsWidget(state: state),
        const Gap(AppSpace.s12),
        Expanded(
          child: filteredRates.isEmpty
              ? Center(
                  child: AppText(
                    key: const Key(TestKeys.rateEmptyState),
                    text: context.l10n.rateEmptyState,
                    style: AppTextStyles.regular12Hintstyle,
                  ),
                )
              : ListView.separated(
                  itemCount: filteredRates.length,
                  separatorBuilder: (_, _) => const Gap(AppSpace.s12),
                  itemBuilder: (_, index) =>
                      RateCardWidget(rate: filteredRates[index]),
                ),
        ),
      ],
    );
  }
}
