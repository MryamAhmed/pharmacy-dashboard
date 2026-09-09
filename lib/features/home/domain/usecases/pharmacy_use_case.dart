import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/domain/entities/app_error.dart';
import '../entities/pharmacy_entity.dart';
import '../repositories/pharmacy_repo.dart';

@injectable
class PharmacyUseCase {
  PharmacyRepository pharmacyRepository;
  PharmacyUseCase({required this.pharmacyRepository});

  Future<Either<AppError, List<PharmacyEntity>>> call() async {
    return await pharmacyRepository.getPharmacyData();
  }
}
