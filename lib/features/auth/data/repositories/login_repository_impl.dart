import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmacy_app/features/auth/domian/repositories/login_repository.dart';

import '../../../../shared/domain/entities/app_error.dart';
import '../../domian/entities/login_entity.dart';
import '../datasources/login_remote_data_source.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this.loginRemoteDataSource);
  final LoginRemoteDataSource loginRemoteDataSource;

  @override
  Future<Either<AppError, AuthEntity>> login(
    String email,
    String password,
  ) async {
    final result = await loginRemoteDataSource.login(
      email: email,
      password: password,
    );
    return result.fold(
      (failure) => Left(failure.toAppError()),
      (response) => Right(response.toDomain()),
    );
  }
}
