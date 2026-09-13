import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmacy_app/features/home/domain/entities/pharmacy_entity.dart';

import '../../../../shared/domain/entities/app_error.dart';
import '../../domain/repositories/pharmacy_repo.dart';
import '../datasources/pharmasy_remote_data_source.dart';

@LazySingleton(as: PharmacyRepository)
class PharmacyRepositoryImpl implements PharmacyRepository {
  PharmasyRemoteDataSource pharmasyRemoteDataSource =
      PharmasyRemoteDataSourceImpl();
  @override
  Future<Either<AppError, List<PharmacyEntity>>> getPharmacyData() async {
    final result = await pharmasyRemoteDataSource.getPharmasyData();
    return result.fold(
      (failure) => Left(failure.toAppError()),
      (responses) => Right(responses.map((r) => r.toDomain()).toList()),
    );
  }
}
