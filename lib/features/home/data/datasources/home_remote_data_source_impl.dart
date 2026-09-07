import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_endpoints.dart';
import '../../../../shared/data/models/failure.dart';
import '../../../../shared/data/network/call_api.dart';
import '../../../../shared/data/network/dio_client_service.dart';
import '../models/data_home_summary_model.dart';
import 'home_remote_data_source.dart';

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
