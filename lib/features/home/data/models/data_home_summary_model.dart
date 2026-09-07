// Project imports:
import '../../../../core/constants/api_param_constatnts.dart';
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
        totalDoctors: json[ApiParamConstants.totalDoctors],
        totalPharmacies: json[ApiParamConstants.totalPharmacies],
        totalActiveJobs: json[ApiParamConstants.totalActiveJobs],
        totalApplications: json[ApiParamConstants.totalApplications],
        totalReviews: json[ApiParamConstants.totalReviews],
      );

  HomeSummaryEntity toDomain() => HomeSummaryEntity(
    totalDoctors: totalDoctors,
    totalPharmacies: totalPharmacies,
    totalActiveJobs: totalActiveJobs,
    totalApplications: totalApplications,
    totalReviews: totalReviews,
  );
}
