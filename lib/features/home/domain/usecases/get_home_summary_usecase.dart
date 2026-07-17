// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../shared/domain/entities/app_error.dart';
import '../entities/home_summary_entity.dart';
import '../repositories/home_repository.dart';

/// Fetches the Home tab's dashboard summary.
@injectable
class GetHomeSummaryUseCase {
  const GetHomeSummaryUseCase(this._repository);

  final HomeRepository _repository;

  Future<Either<AppError, HomeSummaryEntity>> call() =>
      _repository.getHomeSummary();
}
