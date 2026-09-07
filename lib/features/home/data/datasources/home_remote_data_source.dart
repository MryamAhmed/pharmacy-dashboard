// Package imports:
import 'package:fpdart/fpdart.dart';

// Project imports:
import '../../../../shared/data/models/failure.dart';
import '../models/data_home_summary_model.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, DataHomeSummaryModel>> getHomeSummary();
}
