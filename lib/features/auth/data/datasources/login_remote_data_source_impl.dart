import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_endpoints.dart';
import '../../../../core/constants/request_constants.dart';
import '../../../../shared/data/models/failure.dart';
import '../../../../shared/data/network/call_api.dart';
import '../../../../shared/data/network/dio_client_service.dart';
import '../models/login_data_model.dart';
import 'login_remote_data_source.dart';

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  LoginRemoteDataSourceImpl(this._dioClient);

  final DioClientService _dioClient;

  @override
  Future<Either<Failure, LoginDataResponse>> login({
    required String email,
    required String password,
  }) async {
    return await callApi(
      request: () {
        return _dioClient.post(
          url: AppEndPoints.login,
          data: {
            RequestConstants.email: email,
            RequestConstants.password: password,
          },
        );
      },
      mapSuccess: (Map<String, dynamic> data) {
        return LoginDataResponse.fromJson(data);
      },
    );
  }
}
