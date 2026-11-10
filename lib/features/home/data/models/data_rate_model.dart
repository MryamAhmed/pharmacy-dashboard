import '../../../../core/constants/api_param_constatnts.dart';
import '../../domain/entities/rate_entity.dart';

/// One item of `GET Dashboard/reviews` → `data[]`. This is the only review
/// endpoint with data — there is no review-details GET (`Dashboard/review/{id}`
/// accepts DELETE only), so the details screen shows this same object.
class DataRateModel {
  String? id;
  String? comment;
  String? profilePicture;
  String? reviewerName;
  String? reviewerPosition;
  int? rate;
  String? reviewerId;
  String? revieweeId;
  String? revieweeName;
  String? revieweeAddress;
  String? exp;
  String? createdAt;

  DataRateModel({
    this.id,
    this.comment,
    this.profilePicture,
    this.reviewerName,
    this.reviewerPosition,
    this.rate,
    this.reviewerId,
    this.revieweeId,
    this.revieweeName,
    this.revieweeAddress,
    this.exp,
    this.createdAt,
  });

  DataRateModel.fromJson(Map<String, dynamic> json) {
    id = json[ApiParamConstants.id];
    comment = json[ApiParamConstants.comment];
    profilePicture = json[ApiParamConstants.profilePicture];
    reviewerName = json[ApiParamConstants.reviewerName];
    reviewerPosition = json[ApiParamConstants.reviewerPosition];
    // The API sends `rate` as a decimal (e.g. 4.0). Assigning that straight
    // to `int?` throws, which made callApiList drop the whole list. Read it
    // as any number and round to whole stars.
    rate = (json[ApiParamConstants.rate] as num?)?.round();
    reviewerId = json[ApiParamConstants.reviewerId];
    revieweeId = json[ApiParamConstants.revieweeId];
    revieweeName = json[ApiParamConstants.revieweeName];
    // `?.toString()`: the sample only shows "" / "test", so the real type is
    // not guaranteed — a number would otherwise throw and drop the list.
    revieweeAddress = json[ApiParamConstants.revieweeAddress]?.toString();
    exp = json[ApiParamConstants.exp]?.toString();
    createdAt = json[ApiParamConstants.createdAt];
  }

  Map<String, dynamic> toJson() => {
    ApiParamConstants.id: id,
    ApiParamConstants.comment: comment,
    ApiParamConstants.profilePicture: profilePicture,
    ApiParamConstants.reviewerName: reviewerName,
    ApiParamConstants.reviewerPosition: reviewerPosition,
    ApiParamConstants.rate: rate,
    ApiParamConstants.reviewerId: reviewerId,
    ApiParamConstants.revieweeId: revieweeId,
    ApiParamConstants.revieweeName: revieweeName,
    ApiParamConstants.revieweeAddress: revieweeAddress,
    ApiParamConstants.exp: exp,
    ApiParamConstants.createdAt: createdAt,
  };

  /// Maps to the domain entity used by the Rate list and the details screen.
  RateEntity toDomain() {
    return RateEntity(
      id: id,
      comment: comment,
      profilePicture: profilePicture,
      reviewerName: reviewerName,
      reviewerPosition: reviewerPosition,
      rate: rate,
      reviewerId: reviewerId,
      revieweeId: revieweeId,
      revieweeName: revieweeName,
      revieweeAddress: revieweeAddress,
      exp: exp,
      createdAt: createdAt,
    );
  }
}
