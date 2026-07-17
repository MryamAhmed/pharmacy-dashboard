// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../shared/data/models/failure.dart';
import '../models/home_summary_response.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, HomeSummaryResponse>> getHomeSummary();
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
  const HomeRemoteDataSourceImpl();

  @override
  Future<Either<Failure, HomeSummaryResponse>> getHomeSummary() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const Right(HomeSummaryResponse(greeting: 'Welcome back'));
  }
}
