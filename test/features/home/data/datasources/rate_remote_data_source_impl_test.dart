import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pharmacy_app/core/constants/app_endpoints.dart';
import 'package:pharmacy_app/features/home/data/datasources/rate_remote_data_source_impl.dart';
import 'package:pharmacy_app/shared/data/network/dio_client_service.dart';

// The data source's only dependency is DioClientService => we mock it,
// so the test never makes a real network call.
class MockDioClientService extends Mock implements DioClientService {}

void main() {
  late MockDioClientService mockDioClientService;
  late RateRemoteDataSourceImpl dataSource;

  // One review item, same shape as the real server (copied from Postman)
  final reviewJson = <String, dynamic>{
    'id': '1',
    'comment': 'was wonderful',
    'profilePicture': null,
    'reviewerName': 'Maryam',
    'reviewerPosition': null,
    'rate': 4,
    'reviewerId': null,
    'revieweeId': null,
    'revieweeName': 'Fares',
    'createdAt': '2026-07-18T02:15:58',
  };

  // Builds a fake Dio Response. Dio requires `requestOptions`, so we pass one.
  Response<dynamic> fakeResponse({required int statusCode, dynamic data}) =>
      Response<dynamic>(
        requestOptions: RequestOptions(path: AppEndPoints.reviews),
        statusCode: statusCode,
        data: data,
      );

  setUp(() {
    mockDioClientService = MockDioClientService();
    // Safe to create here: unlike the cubit, the constructor does no work
    dataSource = RateRemoteDataSourceImpl(dioClientService: mockDioClientService);
  });

  group('RateRemoteDataSourceImpl.getRates', () {
    test('returns models when server responds 200 with data', () async {
      //arrange: the WHOLE server response (message + success + data),
      // because the data source receives all of it, not just one item
      when(() => mockDioClientService.get(url: AppEndPoints.reviews)).thenAnswer(
        (_) async => fakeResponse(
          statusCode: 200,
          data: <String, dynamic>{
            'message': 'Reviews retrieved successfully',
            'success': true,
            'data': <dynamic>[reviewJson],
          },
        ),
      );

      //act
      final result = await dataSource.getRates();

      //assert: success box, 1 model, fields parsed from the item
      expect(result.isRight(), true);
      final models = result.getOrElse((_) => []);
      expect(models.length, 1);
      expect(models.first.id, '1');
      expect(models.first.reviewerName, 'Maryam');
      expect(models.first.rate, 4);

      // it called the right endpoint, once
      verify(() => mockDioClientService.get(url: AppEndPoints.reviews)).called(1);
    });

    test('returns empty list when server responds 200 with no reviews', () async {
      //arrange
      when(() => mockDioClientService.get(url: AppEndPoints.reviews)).thenAnswer(
        (_) async => fakeResponse(
          statusCode: 200,
          data: <String, dynamic>{'success': true, 'data': <dynamic>[]},
        ),
      );

      //act
      final result = await dataSource.getRates();

      //assert: still success, just an empty list
      expect(result.isRight(), true);
      expect(result.getOrElse((_) => []), isEmpty);
    });

    test('returns Failure when server responds with an error status', () async {
      //arrange: a 500 with the backend's error envelope
      when(() => mockDioClientService.get(url: AppEndPoints.reviews)).thenAnswer(
        (_) async => fakeResponse(
          statusCode: 500,
          data: <String, dynamic>{'success': false, 'message': 'Server error'},
        ),
      );

      //act
      final result = await dataSource.getRates();

      //assert: error box with the status + message read from the response
      expect(result.isLeft(), true);
      final failure = result.getLeft().toNullable();
      expect(failure?.statusCode, 500);
      expect(failure?.message, 'Server error');
    });

    test('returns Failure when Dio throws an exception', () async {
      //arrange: Dio throws (thenThrow instead of thenAnswer).
      // We give the exception a response so Failure reads it directly,
      // without checking the real internet connection.
      when(() => mockDioClientService.get(url: AppEndPoints.reviews)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: AppEndPoints.reviews),
          response: fakeResponse(
            statusCode: 404,
            data: <String, dynamic>{'success': false, 'message': 'Not found'},
          ),
        ),
      );

      //act
      final result = await dataSource.getRates();

      //assert: the exception did NOT crash the app, it became a Left
      expect(result.isLeft(), true);
      final failure = result.getLeft().toNullable();
      expect(failure?.statusCode, 404);
      expect(failure?.message, 'Not found');
    });
  });
}
