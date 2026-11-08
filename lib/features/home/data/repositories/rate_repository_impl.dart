// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../shared/domain/entities/app_error.dart';
import '../../domain/entities/rate_entity.dart';
import '../../domain/repositories/rate_repository.dart';
import '../datasources/rate_remote_data_source.dart';

/// Maps the rate data source's models/failures to domain entities/errors.
@LazySingleton(as: RateRepository)
class RateRepositoryImpl implements RateRepository {
  const RateRepositoryImpl(this._dataSource);

  final RateRemoteDataSource _dataSource;

  @override
  Future<Either<AppError, List<RateEntity>>> getRates() async {
    final result = await _dataSource.getRates();
    return result.fold(
      (failure) => Left(failure.toAppError()),
      (responses) => Right(responses.map((r) => r.toDomain()).toList()),
    );
  }

  @override
  Future<Either<AppError, Unit>> deleteRate(String id) async {
    final result = await _dataSource.deleteRate(id);
    // Only the failure needs mapping — success carries no data.
    return result.mapLeft((failure) => failure.toAppError());
  }
}
