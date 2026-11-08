import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_endpoints.dart';
import '../../../../shared/data/models/failure.dart';
import '../../../../shared/data/network/call_api.dart';
import '../../../../shared/data/network/dio_client_service.dart';
import '../models/data_rate_model.dart';
import 'rate_remote_data_source.dart';

/// Calls the dashboard reviews endpoints through the shared, authenticated
/// [DioClientService].
@LazySingleton(as: RateRemoteDataSource)
class RateRemoteDataSourceImpl implements RateRemoteDataSource {
  RateRemoteDataSourceImpl({required this.dioClientService});

  // Injected by DI — never `DioClientService()` here (that client has no token).
  final DioClientService dioClientService;

  @override
  Future<Either<Failure, List<DataRateModel>>> getRates() async {
    return callApiList(
      request: () => dioClientService.get(url: AppEndPoints.reviews),
      mapItem: (data) => DataRateModel.fromJson(data),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteRate(String id) {
    // The delete response has no body we need, so only the status matters.
    return callApiNoData(
      request: () => dioClientService.delete(url: AppEndPoints.deleteReview(id)),
    );
  }
}
