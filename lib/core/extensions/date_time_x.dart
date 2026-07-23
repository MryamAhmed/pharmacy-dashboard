// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import 'build_context_localizations.dart';

extension DateTimeX on DateTime {
  /// Coarse "Xm/Xh/Xd ago" elapsed-time label, computed against [DateTime.now].
  String relativeTime(BuildContext context) {
    final l10n = context.l10n;
    final diff = DateTime.now().difference(this);
    if (diff.inDays > 0) return l10n.relativeTimeDaysAgo(diff.inDays);
    if (diff.inHours > 0) return l10n.relativeTimeHoursAgo(diff.inHours);
    if (diff.inMinutes > 0) {
      return l10n.relativeTimeMinutesAgo(diff.inMinutes);
    }
    return l10n.relativeTimeJustNow;
  }
}
