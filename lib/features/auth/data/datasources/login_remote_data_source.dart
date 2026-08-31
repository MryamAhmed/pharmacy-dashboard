import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmacy_app/features/auth/data/models/login_response_model.dart';

import '../../../../core/constants/app_end_points.dart';
import '../../../../core/constants/request_constants.dart';
import '../../../../shared/data/models/failure.dart';
import '../../../../shared/data/network/call_api.dart';
import '../../../../shared/data/network/dio_client_service.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  });
}

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  LoginRemoteDataSourceImpl(this._dioClient);

  final DioClientService _dioClient;

  @override
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    return await callApi(
      request: () {
        return _dioClient.post(url: AppEndPoints.login,data: {
          RequestConstants.email: email,
          RequestConstants.password: password,
        });
      },
      mapSuccess: (Map<String, dynamic> data) {
        return LoginResponse.fromJson(data);
      },
    );
  }
}
