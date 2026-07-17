// Package imports:
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

// Project imports:
import '../models/failure.dart';

bool _isSuccess(
  int status,
  dynamic body, [
  bool Function(dynamic data)? dataCheck,
]) =>
    status >= 200 &&
    status < 300 &&
    // body is Map<String, dynamic> &&
    // body['success'] == true &&
    (dataCheck == null || dataCheck(body['data']));

/// Wraps a Dio request that returns a single object payload.
///
/// Supports two response shapes:
/// - Wrapped: `{ "success": true, "data": { ... } }`
/// - Direct:  `{ "_id": "...", ... }`
Future<Either<Failure, T>> callApi<T>({
  required Future<Response<dynamic>> Function() request,
  required T Function(Map<String, dynamic> data) mapSuccess,
}) async {
  try {
    final response = await request();
    final status = response.statusCode ?? 0;
    final body = response.data;

    if (status < 200 || status >= 300 || body is! Map<String, dynamic>) {
      return Left(Failure.fromResponse(response));
    }

    // Wrapped format
    if (body['success'] == true && body['data'] is Map<String, dynamic>) {
      return Right(mapSuccess(body['data'] as Map<String, dynamic>));
    }

    // Direct format
    return Right(mapSuccess(body));
  } catch (e) {
    return Left(Failure.fromException(e));
  }
}

/// Wraps a Dio request that returns a list payload.
///
/// Supports two response shapes:
/// - Wrapped: `{ "success": true, "data": [ ... ] }`
/// - Direct:  `[ { ... }, ... ]`
Future<Either<Failure, List<T>>> callApiList<T>({
  required Future<Response<dynamic>> Function() request,
  required T Function(Map<String, dynamic> data) mapItem,
}) async {
  try {
    final response = await request();
    final status = response.statusCode ?? 0;
    final body = response.data;

    if (status < 200 || status >= 300) {
      return Left(Failure.fromResponse(response));
    }

    List<dynamic> rawList;

    // Wrapped format
    if (body is Map<String, dynamic> &&
        body['success'] == true &&
        body['data'] is List<dynamic>) {
      rawList = body['data'] as List<dynamic>;
    }
    // Direct format
    else if (body is List<dynamic>) {
      rawList = body;
    } else {
      return Left(Failure.fromResponse(response));
    }

    return Right(
      rawList.whereType<Map<String, dynamic>>().map(mapItem).toList(),
    );
  } catch (e) {
    return Left(Failure.fromException(e));
  }
}

/// Wraps a Dio request whose response payload has no data to parse.
///
/// The expected response shape is:
/// `{ "success": true }`
Future<Either<Failure, Unit>> callApiNoData({
  required Future<Response<dynamic>> Function() request,
}) async {
  try {
    final response = await request();
    final status = response.statusCode ?? 0;
    final body = response.data;
    if (!_isSuccess(status, body)) {
      return Left(Failure.fromResponse(response));
    }
    return const Right(unit);
  } catch (e) {
    return Left(Failure.fromException(e));
  }
}
