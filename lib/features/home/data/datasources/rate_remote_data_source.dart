// Package imports:
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../core/enums/rate_status.dart';
import '../../../../shared/data/models/failure.dart';
import '../models/rate_response.dart';

abstract class RateRemoteDataSource {
  Future<Either<Failure, List<RateResponse>>> getRates();
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
  const RateRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<RateResponse>>> getRates() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return Right([
      RateResponse(
        id: '1',
        pharmacyName: 'Al Shifa Pharmacy',
        userName: 'Ahmed Youssef',
        dateTime: DateTime(2026, 7, 15, 10, 30),
        status: RateStatus.pending,
        reviewText: 'Great service and fast delivery.',
        rate: 5,
      ),
      RateResponse(
        id: '2',
        pharmacyName: 'Al Ezaby Pharmacy',
        userName: 'Mona Hassan',
        dateTime: DateTime(2026, 7, 14, 16, 45),
        status: RateStatus.approve,
        reviewText: 'Good prices, friendly staff.',
        rate: 4,
      ),
      RateResponse(
        id: '3',
        pharmacyName: 'Seif Pharmacy',
        userName: 'Karim Adel',
        dateTime: DateTime(2026, 7, 13, 9, 15),
        status: RateStatus.reject,
        reviewText: 'Review contained inappropriate language.',
        rate: 1,
      ),
      RateResponse(
        id: '4',
        pharmacyName: 'Al Dawaa Pharmacy',
        userName: 'Sara Ali',
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        status: RateStatus.pending,
        reviewText: 'Fast and friendly service, highly recommend.',
        rate: 4,
      ),
      RateResponse(
        id: '5',
        pharmacyName: 'Nahdi Pharmacy',
        userName: 'Omar Khaled',
        dateTime: DateTime.now().subtract(const Duration(minutes: 20)),
        status: RateStatus.pending,
        reviewText: 'Average experience, could be faster.',
        rate: 3,
      ),
      RateResponse(
        id: '6',
        pharmacyName: 'United Pharmacy',
        userName: 'Laila Nasser',
        dateTime: DateTime.now().subtract(const Duration(days: 2)),
        status: RateStatus.pending,
        reviewText: 'Staff was rude and unhelpful.',
        rate: 2,
      ),
    ]);
  }
}
