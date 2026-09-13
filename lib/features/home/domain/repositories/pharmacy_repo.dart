import 'package:fpdart/fpdart.dart';

import '../../../../shared/domain/entities/app_error.dart';
import '../entities/pharmacy_entity.dart';

abstract class PharmacyRepository {
  Future<Either<AppError, List<PharmacyEntity>>> getPharmacyData();
}
