import 'package:fpdart/fpdart.dart';

import '../../../../shared/data/models/failure.dart';
import '../models/login_data_model.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, LoginDataResponse>> login({
    required String email,
    required String password,
  });
}
