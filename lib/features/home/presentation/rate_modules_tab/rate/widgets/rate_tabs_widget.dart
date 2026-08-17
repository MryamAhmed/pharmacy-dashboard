import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/enums/rate_rating_filter.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../cubit/rate_cubit.dart';
import '../cubit/rate_state.dart';
import 'rate_tab_item_widget.dart';

class RateTabsWidget extends StatelessWidget {
  final RateState state;
  const RateTabsWidget({super.key, required this.state});

  String _filterLabel(BuildContext context, RateRatingFilter filter) =>
      switch (filter) {
        RateRatingFilter.all => context.l10n.rateFilterAll,
        RateRatingFilter.five => context.l10n.rateFilterFiveStars,
        RateRatingFilter.four => context.l10n.rateFilterFourStars,
        RateRatingFilter.three => context.l10n.rateFilterThreeStars,
        RateRatingFilter.oneOrTwo => context.l10n.rateFilterOneOrTwoStars,
      };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Row(
        children: [
          for (final filter in RateRatingFilter.values) ...[
            Expanded(
              child: RateTabItemWidget(
                isSelected: state.selectedFilter == filter,
                filter: filter,
                title:
                    '${_filterLabel(context, filter)} (${state.countFor(filter)})',
                onTap: () => context.read<RateCubit>().selectFilter(filter),
              ),
            ),
            if (filter != RateRatingFilter.values.last) const Gap(AppSpace.s8),
          ],
        ],
      ),
    );
  }
}
