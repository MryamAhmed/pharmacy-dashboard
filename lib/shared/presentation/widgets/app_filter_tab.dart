// Flutter imports:
import 'package:flutter/foundation.dart';

/// Config for one chip in [AppFilterTabsWidget].
///
/// Not a widget — callers build a list of these (4, 5, or any length) and
/// the shared row renders one chip per entry. [count] is optional so Rate
/// can show `All (12)` while another screen can show label-only chips.
class AppFilterTab<T> {
  const AppFilterTab({
    required this.value,
    required this.title,
    required this.itemKey,
    this.count,
  });

  /// Value reported back via [AppFilterTabsWidget.onSelected] when tapped.
  final T value;

  /// Localized label. When [count] is set, the chip shows `title (count)`.
  final String title;

  /// Shown in parentheses after [title]. Omit for label-only chips.
  final int? count;

  /// [Key] applied to the chip so tests can find it via [TestKeys].
  final Key itemKey;
}
