/// Star-rating bucket used to filter the Rate tab's pending reviews.
enum RateRatingFilter {
  all,
  five,
  four,
  three,
  oneOrTwo;

  /// Whether a review's `rate` (1-5) falls into this bucket.
  bool matches(int rate) => switch (this) {
    RateRatingFilter.all => true,
    RateRatingFilter.five => rate == 5,
    RateRatingFilter.four => rate == 4,
    RateRatingFilter.three => rate == 3,
    RateRatingFilter.oneOrTwo => rate == 1 || rate == 2,
  };
}
