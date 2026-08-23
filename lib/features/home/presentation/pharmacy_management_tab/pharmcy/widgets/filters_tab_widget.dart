import 'package:flutter/widgets.dart';

import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/enums/pharmacy_filter.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../shared/presentation/widgets/app_filter_tab.dart';
import '../../../../../../shared/presentation/widgets/app_filter_tabs_widget.dart';

class FiltersTap extends StatelessWidget {
  const FiltersTap({super.key});

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
      selectedValue: PharmacyFilter.all,
      onSelected: (filter) {},
    );
  }

  String filterTapLabel(BuildContext context, PharmacyFilter filter) =>
      switch (filter) {
        PharmacyFilter.all => context.l10n.rateFilterAll,
        PharmacyFilter.Verified => context.l10n.rateFilterVerified,
        PharmacyFilter.Pending => context.l10n.rateFilterPending,
        PharmacyFilter.Suspended => context.l10n.rateFilterSuspended,
      };
}
