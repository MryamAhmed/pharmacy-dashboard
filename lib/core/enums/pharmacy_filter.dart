import 'pharmacy_status.dart';

enum PharmacyFilter {
  all,
  Pending,
  Suspended;

  bool matches(String status) {
    // Compare against the enum's `.name` — comparing a String to the enum
    // value itself is always false, so Pending/Suspended matched nothing.
    final normalized = status.toLowerCase();
    switch (this) {
      case PharmacyFilter.all:
        return true;
      case PharmacyFilter.Pending:
        return normalized == PharmacyStatus.pending.name;
      case PharmacyFilter.Suspended:
        return normalized == PharmacyStatus.suspended.name;
    }
  }
}
