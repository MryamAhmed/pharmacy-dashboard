// Project imports:
import '../../../../core/enums/rate_status.dart';

/// A single pending pharmacy rating awaiting admin review.
class RateEntity {
  const RateEntity({
    required this.id,
    required this.pharmacyName,
    required this.userName,
    required this.dateTime,
    required this.status,
    required this.reviewText,
    required this.rate,
  });

  final String id;
  final String pharmacyName;
  final String userName;
  final DateTime dateTime;
  final RateStatus status;
  final String reviewText;
  final int rate;
}
