class AppEndPoints {
  static const String login = '/Auth/login';
  static const String homeSummary = '/Dashboard/stats';
  static const String reviews = '/Dashboard/reviews';
  static const String pharmacies = '/Dashboard/pharmacies';

  /// DELETE — removes a single review by its id.
  static String deleteReview(String id) => '/Dashboard/review/$id';
}
