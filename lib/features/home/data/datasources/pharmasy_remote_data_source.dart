import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_endpoints.dart';
import '../../../../shared/data/models/failure.dart';
import '../../../../shared/data/network/call_api.dart';
import '../../../../shared/data/network/dio_client_service.dart';
import '../models/pharmasy_data_model.dart';

abstract class PharmasyRemoteDataSource {
  Future<Either<Failure, List<PharmasyDataModel>>> getPharmasyData();
}
/// Fetches the pharmacy list from the dashboard API.
@LazySingleton(as: PharmasyRemoteDataSource)
class PharmasyRemoteDataSourceImpl implements PharmasyRemoteDataSource {
  // Injected by DI so this uses the app-wide client that carries the auth
  // token. Creating `DioClientService()` here made a second client with no
  // token, so the request was unauthorized and returned nothing.
  PharmasyRemoteDataSourceImpl(this._dioClientService);

  final DioClientService _dioClientService;

  @override
  Future<Either<Failure, List<PharmasyDataModel>>> getPharmasyData() {
    return callApiList(
      request: () {
        return _dioClientService.get(url: AppEndPoints.pharmacies);
      },
      mapItem: (Map<String, dynamic> data) {
        return PharmasyDataModel.fromJson(data);
      },
    );
  }
}
