import '../../../../core/constants/api_param_constatnts.dart';
import '../../domain/entities/rate_entity.dart';

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
    this.createdAt,
  });

  DataRateModel.fromJson(Map<String, dynamic> json) {
    id = json[ApiParamConstants.id];
    comment = json[ApiParamConstants.comment];
    profilePicture = json[ApiParamConstants.profilePicture];
    reviewerName = json[ApiParamConstants.reviewerName];
    reviewerPosition = json[ApiParamConstants.reviewerPosition];
    rate = json[ApiParamConstants.rate];
    reviewerId = json[ApiParamConstants.reviewerId];
    revieweeId = json[ApiParamConstants.revieweeId];
    revieweeName = json[ApiParamConstants.revieweeName];
    createdAt = json[ApiParamConstants.createdAt];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ApiParamConstants.id] = this.id;
    data[ApiParamConstants.comment] = this.comment;
    data[ApiParamConstants.profilePicture] = this.profilePicture;
    data[ApiParamConstants.reviewerName] = this.reviewerName;
    data[ApiParamConstants.reviewerPosition] = this.reviewerPosition;
    data[ApiParamConstants.rate] = this.rate;
    data[ApiParamConstants.reviewerId] = this.reviewerId;
    data[ApiParamConstants.revieweeId] = this.revieweeId;
    data[ApiParamConstants.revieweeName] = this.revieweeName;
    data[ApiParamConstants.createdAt] = this.createdAt;
    return data;
  }

  //to entity
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
      createdAt: createdAt,
    );
  }
}
