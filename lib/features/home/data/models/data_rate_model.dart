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
    id = json['id'];
    comment = json['comment'];
    profilePicture = json['profilePicture'];
    reviewerName = json['reviewerName'];
    reviewerPosition = json['reviewerPosition'];
    rate = json['rate'];
    reviewerId = json['reviewerId'];
    revieweeId = json['revieweeId'];
    revieweeName = json['revieweeName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['profilePicture'] = this.profilePicture;
    data['reviewerName'] = this.reviewerName;
    data['reviewerPosition'] = this.reviewerPosition;
    data['rate'] = this.rate;
    data['reviewerId'] = this.reviewerId;
    data['revieweeId'] = this.revieweeId;
    data['revieweeName'] = this.revieweeName;
    data['createdAt'] = this.createdAt;
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
