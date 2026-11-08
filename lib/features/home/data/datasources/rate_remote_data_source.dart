// Package imports:
import 'package:fpdart/fpdart.dart';

// Project imports:
import '../../../../shared/data/models/failure.dart';
import '../models/data_rate_model.dart';

/// Remote API contract for the Rate tab's reviews.
abstract class RateRemoteDataSource {
  Future<Either<Failure, List<DataRateModel>>> getRates();

  /// Deletes the review with [id]. Returns [unit] on any 2xx response.
  Future<Either<Failure, Unit>> deleteRate(String id);
}
