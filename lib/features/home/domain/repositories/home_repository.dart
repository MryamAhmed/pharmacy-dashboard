// Package imports:
import 'package:fpdart/fpdart.dart';

// Project imports:
import '../../../../shared/domain/entities/app_error.dart';
import '../entities/home_summary_entity.dart';

/// Domain-facing contract for the home module's data.
abstract class HomeRepository {
  Future<Either<AppError, HomeSummaryEntity>> getHomeSummary();
}
