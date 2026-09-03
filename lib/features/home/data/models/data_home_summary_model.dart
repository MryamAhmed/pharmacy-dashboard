// Project imports:
import '../../domain/entities/home_summary_entity.dart';

/// Data-layer shape of the home summary response.
class DataHomeSummaryModel {
  const DataHomeSummaryModel({
    required this.totalDoctors,
    required this.totalPharmacies,
    required this.totalActiveJobs,
    required this.totalApplications,
    required this.totalReviews,
  });
  final int totalDoctors;
  final int totalPharmacies;
  final int totalActiveJobs;
  final int totalApplications;
  final int totalReviews;
  factory DataHomeSummaryModel.fromJson(Map<String, dynamic> json) =>
      DataHomeSummaryModel(
        totalDoctors: json['totalDoctors'] ,
        totalPharmacies: json['totalPharmacies'] ,
        totalActiveJobs: json['totalActiveJobs'] ,
        totalApplications: json['totalApplications'],
        totalReviews: json['totalReviews'],
      );

  HomeSummaryEntity toDomain() => HomeSummaryEntity(
        totalDoctors: totalDoctors,
        totalPharmacies: totalPharmacies,
        totalActiveJobs: totalActiveJobs,
        totalApplications: totalApplications,
        totalReviews: totalReviews,
      );
}
