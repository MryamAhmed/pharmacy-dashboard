import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_endpoints.dart';
import '../../../../shared/data/models/failure.dart';
import '../../../../shared/data/network/call_api.dart';
import '../../../../shared/data/network/dio_client_service.dart';
import '../models/data_rate_model.dart';
import 'rate_remote_data_source.dart';

@LazySingleton(as: RateRemoteDataSource)
class RateRemoteDataSourceImpl implements RateRemoteDataSource {
  RateRemoteDataSourceImpl({required this.dioClientService});
  DioClientService dioClientService = DioClientService();

  @override
  Future<Either<Failure, List<DataRateModel>>> getRates() async {
    return callApiList(
      request: () => dioClientService.get(url: AppEndPoints.reviews),
      mapItem: (data) => DataRateModel.fromJson(data),
    );
  }
}
