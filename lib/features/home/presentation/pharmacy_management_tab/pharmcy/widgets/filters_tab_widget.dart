import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/enums/pharmacy_filter.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../shared/presentation/widgets/app_filter_tab.dart';
import '../../../../../../shared/presentation/widgets/app_filter_tabs_widget.dart';
import '../cubit/pharmacy_cubit.dart';
import '../cubit/pharmacy_states.dart';

class FiltersTap extends StatelessWidget {
  const FiltersTap({super.key, required this.state});
  final PharmacyState state;

  @override
  Widget build(BuildContext context) {
    return AppFilterTabsWidget<PharmacyFilter>(
      tabs: [
        for (final filter in PharmacyFilter.values)
          AppFilterTab<PharmacyFilter>(
            value: filter,
            title: filterTapLabel(context, filter),
            itemKey: Key('${TestKeys.pharmacyFilterTab}_${filter.name}'),
          ),
      ],
      selectedValue:state.selectedFilter,
      onSelected: (filter) => context.read<PharmacyCubit>().selectFilter(filter),
    );
  }

  String filterTapLabel(BuildContext context, PharmacyFilter filter) =>
      switch (filter) {
        PharmacyFilter.all => context.l10n.rateFilterAll,
        PharmacyFilter.Pending => context.l10n.rateFilterPending,
        PharmacyFilter.Suspended => context.l10n.rateFilterSuspended,
      };
}
