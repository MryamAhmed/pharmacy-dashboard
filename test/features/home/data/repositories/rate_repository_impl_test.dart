import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pharmacy_app/features/home/data/datasources/rate_remote_data_source.dart';
import 'package:pharmacy_app/features/home/data/models/data_rate_model.dart';
import 'package:pharmacy_app/features/home/data/repositories/rate_repository_impl.dart';
import 'package:pharmacy_app/shared/data/models/failure.dart';

//what is the repo impl do?   => call remote data sourse => we need insyance from RateRemoteDataSource
class MockRateRemoteDataSource extends Mock implements RateRemoteDataSource {}

void main() {
  late MockRateRemoteDataSource mockRateRemoteDataSource;
  late RateRepositoryImpl rateRepositoryImpl;

  setUp(() {
    mockRateRemoteDataSource = MockRateRemoteDataSource();
    rateRepositoryImpl = RateRepositoryImpl(mockRateRemoteDataSource);
  });

  group('RateRepositoryImpl.getRates', () {
    test('returns entities when data source succeeds', () async {
      //arrange: the MOCK returns the data source's type => DataRateModel
      final fakeRates = [
        DataRateModel(
          id: '1',
          comment: 'comment',
          profilePicture: 'empty',
          reviewerName: 'Maryam',
          reviewerPosition: 'Ahmed',
          reviewerId: '2',
          rate: null,
          revieweeId: '3',
          revieweeName: 'Fares',
          createdAt: 'empty',
        ),
      ];
      when(
        () => mockRateRemoteDataSource.getRates(),
      ).thenAnswer((_) async => Right(fakeRates));

      //act: call the REAL class we are testing
      final result = await rateRepositoryImpl.getRates();

      //assert: the result has the repository's type => RateEntity
      // 1. it must be the success box
      expect(result.isRight(), true);

      // 2. take the list out of the box ([] if it was Left)
      final rates = result.getOrElse((_) => []);
      expect(rates.length, 1);

      // 3. every field must be copied from the model to the entity (toDomain)
      final rate = rates.first;
      expect(rate.id, '1');
      expect(rate.comment, 'comment');
      expect(rate.profilePicture, 'empty');
      expect(rate.reviewerName, 'Maryam');
      expect(rate.reviewerPosition, 'Ahmed');
      expect(rate.reviewerId, '2');
      expect(rate.rate, isNull);
      expect(rate.revieweeId, '3');
      expect(rate.revieweeName, 'Fares');
      expect(rate.createdAt, 'empty');

      // the repository asked the data source exactly once
      verify(() => mockRateRemoteDataSource.getRates()).called(1);
    });

    test('returns AppError when data source fails', () async {
      //arrange: the MOCK returns the data source's error type => Failure
      const fakeFailure = Failure(code: '500', statusCode: 500);
      when(
        () => mockRateRemoteDataSource.getRates(),
      ).thenAnswer((_) async => const Left(fakeFailure));

      //act
      final result = await rateRepositoryImpl.getRates();

      //assert: the result has the repository's error type => AppError
      // 1. it must be the error box
      expect(result.isLeft(), true);

      // 2. take the error out of the box (null if it was Right)
      final error = result.getLeft().toNullable();

      // 3. the Failure fields must be copied into the AppError (toAppError)
      expect(error?.code, '500');
      expect(error?.statusCode, 500);

      verify(() => mockRateRemoteDataSource.getRates()).called(1);
    });
  });
}
