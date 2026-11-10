import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmacy_app/features/home/domain/entities/pharmacy_entity.dart';

import '../../../../shared/domain/entities/app_error.dart';
import '../../domain/repositories/pharmacy_repo.dart';
import '../datasources/pharmasy_remote_data_source.dart';

/// Maps the pharmacy data source's models/failures to domain entities/errors.
@LazySingleton(as: PharmacyRepository)
class PharmacyRepositoryImpl implements PharmacyRepository {
  // Injected by DI (not `PharmasyRemoteDataSourceImpl()`), so it gets the
  // registered data source wired to the shared, authenticated Dio client.
  PharmacyRepositoryImpl(this._pharmasyRemoteDataSource);

  final PharmasyRemoteDataSource _pharmasyRemoteDataSource;

  @override
  Future<Either<AppError, List<PharmacyEntity>>> getPharmacyData() async {
    final result = await _pharmasyRemoteDataSource.getPharmasyData();
    return result.fold(
      (failure) => Left(failure.toAppError()),
      (responses) => Right(responses.map((r) => r.toDomain()).toList()),
    );
  }

  // Success carries no data — only the failure side needs mapping.
  @override
  Future<Either<AppError, Unit>> verifyPharmacy(String pharmacyId) async {
    final result = await _pharmasyRemoteDataSource.verifyPharmacy(pharmacyId);
    return result.mapLeft((failure) => failure.toAppError());
  }

  @override
  Future<Either<AppError, Unit>> unverifyPharmacy(String pharmacyId) async {
    final result = await _pharmasyRemoteDataSource.unverifyPharmacy(
      pharmacyId,
    );
    return result.mapLeft((failure) => failure.toAppError());
  }
}
