// Project imports:
import '../../../../core/enums/rate_status.dart';
import '../../domain/entities/rate_entity.dart';

/// Data-layer shape of a single pending rating.
class RateResponse {
  const RateResponse({
    required this.id,
    required this.pharmacyName,
    required this.userName,
    required this.dateTime,
    required this.status,
    required this.reviewText,
    required this.rate,
  });

  factory RateResponse.fromJson(Map<String, dynamic> json) => RateResponse(
    id: json['id'] as String? ?? '',
    pharmacyName: json['pharmacy_name'] as String? ?? '',
    userName: json['user_name'] as String? ?? '',
    dateTime:
        DateTime.tryParse(json['datetime'] as String? ?? '') ?? DateTime.now(),
    status: RateStatus.fromValue(json['status'] as String?),
    reviewText: json['review_text'] as String? ?? '',
    rate: json['rate'] as int? ?? 0,
  );

  final String id;
  final String pharmacyName;
  final String userName;
  final DateTime dateTime;
  final RateStatus status;
  final String reviewText;
  final int rate;

  RateEntity toDomain() => RateEntity(
    id: id,
    pharmacyName: pharmacyName,
    userName: userName,
    dateTime: dateTime,
    status: status,
    reviewText: reviewText,
    rate: rate,
  );
}
