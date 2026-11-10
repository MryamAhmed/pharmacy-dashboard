// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../shared/domain/entities/app_error.dart';
import '../repositories/pharmacy_repo.dart';

/// Removes a pharmacy's verification (Reject button on the pharmacy details
/// screen).
@injectable
class UnverifyPharmacyUseCase {
  const UnverifyPharmacyUseCase(this._repository);

  final PharmacyRepository _repository;

  Future<Either<AppError, Unit>> call(String pharmacyId) =>
      _repository.unverifyPharmacy(pharmacyId);
}
