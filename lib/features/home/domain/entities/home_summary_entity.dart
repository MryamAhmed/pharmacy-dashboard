/// Placeholder dashboard summary shown on the Home tab.
///
/// Dummy for now — replace with real fields (today's sales, low-stock count,
/// pending orders, etc.) once a backend endpoint exists for the home module.
class HomeSummaryEntity {
  const HomeSummaryEntity({
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
  
}
