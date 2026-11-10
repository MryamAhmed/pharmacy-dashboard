class AppEndPoints {
  static const String login = '/Auth/login';
  static const String homeSummary = '/Dashboard/stats';
  static const String reviews = '/Dashboard/reviews';
  static const String pharmacies = '/Dashboard/pharmacies';

  /// Marks a pharmacy verified (`?pharmacyId=`) → `{ "data": true }`.
  static const String verifyPharmacy = '/Dashboard/verify';

  /// Removes a pharmacy's verification (`?pharmacyId=`) → `{ "data": false }`.
  static const String unverifyPharmacy = '/Dashboard/unverify';

  /// DELETE — removes a single review by its id.
  static String deleteReview(String id) => '/Dashboard/review/$id';
}
