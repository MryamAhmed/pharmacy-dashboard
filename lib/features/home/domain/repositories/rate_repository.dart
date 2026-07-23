// Package imports:
import 'package:fpdart/fpdart.dart';

// Project imports:
import '../../../../shared/domain/entities/app_error.dart';
import '../entities/rate_entity.dart';

/// Domain-facing contract for the Rate tab's data.
abstract class RateRepository {
  Future<Either<AppError, List<RateEntity>>> getRates();
}
