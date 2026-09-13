import 'pharmacy_status.dart';

enum PharmacyFilter {
  all,
  Pending,
  Suspended;

  bool matches(String status) {
    switch (this) {
      case PharmacyFilter.all:
        return true;
      case PharmacyFilter.Pending:
        return status == PharmacyStatus.pending;
      case PharmacyFilter.Suspended:
        return status == PharmacyStatus.suspended;
    }
  }
}
