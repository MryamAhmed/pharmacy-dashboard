// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../shared/domain/entities/app_error.dart';
import '../repositories/rate_repository.dart';

/// Deletes a single review (the Delete button on the rate-details screen).
@injectable
class DeleteRateUseCase {
  const DeleteRateUseCase(this._repository);

  final RateRepository _repository;

  Future<Either<AppError, Unit>> call(String id) => _repository.deleteRate(id);
}
