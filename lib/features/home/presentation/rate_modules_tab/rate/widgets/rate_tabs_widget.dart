// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/enums/rate_rating_filter.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../shared/presentation/widgets/app_filter_tab.dart';
import '../../../../../../shared/presentation/widgets/app_filter_tabs_widget.dart';
import '../cubit/rate_cubit.dart';
import '../cubit/rate_state.dart';

/// Rate-tab adapter around [AppFilterTabsWidget]: maps [RateRatingFilter]
/// buckets (5 chips, each with a pending-review count) onto the shared row.
class RateTabsWidget extends StatelessWidget {
  const RateTabsWidget({super.key, required this.state});

  final RateState state;

  @override
  Widget build(BuildContext context) {
    return AppFilterTabsWidget<RateRatingFilter>(
      tabs: [
        for (final filter in RateRatingFilter.values)
          AppFilterTab<RateRatingFilter>(
            value: filter,
            title: _filterLabel(context, filter),
            count: state.countFor(filter),
            itemKey: Key('${TestKeys.rateFilterTab}_${filter.name}'),
          ),
      ],
      selectedValue: state.selectedFilter,
      onSelected: (filter) => context.read<RateCubit>().selectFilter(filter),
    );
  }

  String _filterLabel(BuildContext context, RateRatingFilter filter) =>
      switch (filter) {
        RateRatingFilter.all => context.l10n.rateFilterAll,
        RateRatingFilter.five => context.l10n.rateFilterFiveStars,
        RateRatingFilter.four => context.l10n.rateFilterFourStars,
        RateRatingFilter.three => context.l10n.rateFilterThreeStars,
        RateRatingFilter.oneOrTwo => context.l10n.rateFilterOneOrTwoStars,
      };
}
