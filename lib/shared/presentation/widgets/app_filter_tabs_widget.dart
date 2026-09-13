// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import '../../../core/constants/app_values.dart';
import 'app_filter_tab.dart';
import 'app_filter_tab_chip_widget.dart';

/// Full-width row of equal-width filter chips.
///
/// The caller decides how many tabs to pass and whether each chip shows a
/// count — Rate uses five chips with counts; another screen can pass four
/// label-only chips. Selection and tap handling stay with the caller.
class AppFilterTabsWidget<T> extends StatelessWidget {
  const AppFilterTabsWidget({
    super.key,
    required this.tabs,
    required this.selectedValue,
    required this.onSelected,
  });

  /// Chips to render, in display order. Any length is valid.
  final List<AppFilterTab<T>> tabs;

  /// Which [AppFilterTab.value] is currently selected.
  final T selectedValue;

  /// Called with the tapped tab's [AppFilterTab.value].
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final tab in tabs) ...[
          Expanded(
            child: AppFilterTabChipWidget(
              key: tab.itemKey,
              title: _chipTitle(tab),
              isSelected: tab.value == selectedValue,
              onTap: () => onSelected(tab.value),
            ),
          ),
          if (tab != tabs.last) const Gap(AppSpace.s8),
        ],
      ],
    );
  }

  /// Appends `(count)` only when the caller supplied a count.
  String _chipTitle(AppFilterTab<T> tab) {
    final count = tab.count;
    if (count == null) return tab.title;
    return '${tab.title} ($count)';
  }
}
