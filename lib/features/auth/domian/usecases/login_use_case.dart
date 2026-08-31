import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/domain/entities/app_error.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repository.dart';

@injectable
class LoginUseCase {
  final LoginRepository loginRepository;
  LoginUseCase(this.loginRepository);
  Future<Either<AppError, AuthEntity>> login(
    String email,
    String password,
  ) async {
    return await loginRepository.login(email, password);
  }
}
