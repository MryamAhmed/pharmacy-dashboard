// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../core/constants/app_end_points.dart';
import '../../../../shared/data/models/failure.dart';
import '../../../../shared/data/network/call_api.dart';
import '../../../../shared/data/network/dio_client_service.dart';
import '../models/data_rate_model.dart';

abstract class RateRemoteDataSource {
  Future<Either<Failure, List<DataRateModel>>> getRates();
}

/// Dummy implementation — no backend endpoint exists yet for the Rate tab.
///
/// Replace the body with a real `callApiList(...)` call against
/// `DioClientService` once the endpoint is available; the return shape
/// (`Either<Failure, List<RateResponse>>`) already matches every other data
/// source in the app, so [RateRepositoryImpl] needs no changes when this
/// becomes real.
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
