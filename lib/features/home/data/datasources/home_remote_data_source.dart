// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmacy_app/shared/data/network/call_api.dart';

// Project imports:
import '../../../../core/constants/app_end_points.dart';
import '../../../../shared/data/models/failure.dart';
import '../../../../shared/data/network/dio_client_service.dart';
import '../models/data_home_summary_model.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, DataHomeSummaryModel>> getHomeSummary();
}

/// Dummy implementation — no backend endpoint exists yet for the home module.
///
/// Replace the body with a real `callApi(...)` call against
/// `DioClientService` once the endpoint is available; the return shape
/// (`Either<Failure, HomeSummaryResponse>`) already matches every other data
/// source in the app, so [HomeRepositoryImpl] needs no changes when this
/// becomes real.
@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl({required this.dioClientService});
  final DioClientService dioClientService;

  @override
  Future<Either<Failure, DataHomeSummaryModel>> getHomeSummary() async {
    return await callApi(
      request: () => dioClientService.get(url: AppEndPoints.homeSummary),
      mapSuccess: (Map<String, dynamic> data) =>
          DataHomeSummaryModel.fromJson(data),
    );
  }
}
