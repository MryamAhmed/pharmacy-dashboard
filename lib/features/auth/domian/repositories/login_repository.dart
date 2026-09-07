import 'package:fpdart/fpdart.dart';

import '../../../../shared/domain/entities/app_error.dart';
import '../entities/login_entity.dart';


abstract class LoginRepository{
Future<Either<AppError, AuthEntity>> login(String email, String password);
}