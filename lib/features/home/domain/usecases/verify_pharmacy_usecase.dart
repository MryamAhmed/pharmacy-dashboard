// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../shared/domain/entities/app_error.dart';
import '../repositories/pharmacy_repo.dart';

/// Verifies a pharmacy (Verify button on the pharmacy card and on the
/// pharmacy details screen).
@injectable
class VerifyPharmacyUseCase {
  const VerifyPharmacyUseCase(this._repository);

  final PharmacyRepository _repository;

  Future<Either<AppError, Unit>> call(String pharmacyId) =>
      _repository.verifyPharmacy(pharmacyId);
}
