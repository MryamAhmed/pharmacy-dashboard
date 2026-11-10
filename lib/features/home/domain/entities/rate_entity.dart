/// A single pending review from `GET Dashboard/reviews`.
///
/// reviewer = who wrote the review (shown on the pharmacy card);
/// reviewee = who is being rated (shown on the "Rating for" card).
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
    this.revieweeAddress,
    this.exp,
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
  final String? revieweeAddress;

  /// The reviewee's experience, as sent by the API (free text, e.g. "test").
  final String? exp;
  final String? createdAt;
}
