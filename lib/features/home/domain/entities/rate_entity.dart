// Project imports:

/// A single pending pharmacy rating awaiting admin review.
class RateEntity {
  const RateEntity({
    required this.id,
    required this.comment,
    required this.profilePicture,
    required this.reviewerName,
    required this.reviewerPosition,
    required this.reviewerId,
    required this.rate,
    required this.revieweeId,
    required this.revieweeName,
    required this.createdAt,
  });

  final String? id;
  final String? comment;
  final String? profilePicture;
  final String? reviewerName;
  final String? reviewerPosition;
  final int? rate;
  final String? reviewerId;
  final String? revieweeId;
  final String? revieweeName;
  final String? createdAt;
}
