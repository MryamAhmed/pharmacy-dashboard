// Package imports:
import 'package:fpdart/fpdart.dart';

// Project imports:
import '../../../../shared/data/models/failure.dart';
import '../models/data_rate_model.dart';

abstract class RateRemoteDataSource {
  Future<Either<Failure, List<DataRateModel>>> getRates();
}
