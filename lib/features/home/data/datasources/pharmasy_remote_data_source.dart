import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/data/models/failure.dart';
import '../../../../shared/data/network/call_api.dart';
import '../../../../shared/data/network/dio_client_service.dart';
import '../models/pharmasy_data_model.dart';

abstract class PharmasyRemoteDataSource {
  Future<Either<Failure, List<PharmasyDataModel>>> getPharmasyData();
}
@LazySingleton(as: PharmasyRemoteDataSource)
class PharmasyRemoteDataSourceImpl implements PharmasyRemoteDataSource {
  DioClientService dioClientService = DioClientService();
  @override
  Future<Either<Failure, List<PharmasyDataModel>>> getPharmasyData() {
    return callApiList(
      request: () {
        return dioClientService.get(url: 'Dashboard/pharmacies');
      },
      mapItem: (Map<String, dynamic> data) {
        return PharmasyDataModel.fromJson(data);
      },
    );
  }
}
