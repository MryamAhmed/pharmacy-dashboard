import 'package:fpdart/fpdart.dart';

import '../../../../shared/domain/entities/app_error.dart';
import '../entities/pharmacy_entity.dart';

/// Domain-facing contract for the Pharmacy Management tab's data.
abstract class PharmacyRepository {
  Future<Either<AppError, List<PharmacyEntity>>> getPharmacyData();

  /// Marks the pharmacy with [pharmacyId] as verified.
  Future<Either<AppError, Unit>> verifyPharmacy(String pharmacyId);

  /// Removes the verification of the pharmacy with [pharmacyId].
  Future<Either<AppError, Unit>> unverifyPharmacy(String pharmacyId);
}
