// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../shared/domain/entities/app_error.dart';
import '../../domain/entities/home_summary_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._dataSource);

  final HomeRemoteDataSource _dataSource;

  @override
  Future<Either<AppError, HomeSummaryEntity>> getHomeSummary() async {
    final result = await _dataSource.getHomeSummary();
    return result.fold(
      (failure) => Left(failure.toAppError()),
      (response) => Right(response.toDomain()),
    );
  }
}
