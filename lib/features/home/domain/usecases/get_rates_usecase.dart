// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../shared/domain/entities/app_error.dart';
import '../entities/rate_entity.dart';
import '../repositories/rate_repository.dart';

/// Fetches the Rate tab's pending ratings.
@injectable
class GetRatesUseCase {
  const GetRatesUseCase(this._repository);

  final RateRepository _repository;

  Future<Either<AppError, List<RateEntity>>> call() => _repository.getRates();
}
