// Package imports:
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:
import '../../../core/constants/request_constants.dart';
import '../../../flavors.dart';

/// Singleton HTTP client wrapping [Dio].
///
/// All HTTP calls go through this — never instantiate `Dio()` directly.
/// Auth headers are managed here via [setAuthToken]; data sources must not
/// set them manually.
class DioClientService {
  DioClientService() {
    final baseOptions = BaseOptions(
      baseUrl: Flavor.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    _dio = Dio(baseOptions);
    _dio.interceptors.addAll([
      if (Flavor.enableNetworkLogger) PrettyDioLogger(requestBody: true),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers[RequestConstants.contentType] =
              RequestConstants.kApplicationJson;
          if (_authToken != null) {
            options.headers[RequestConstants.authorization] =
                '${RequestConstants.bearer} $_authToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          // Session expiry is handled globally here (not per-feature): any 401
          // notifies the registered [onUnauthorized] listener (wired by
          // GeneralCubit to clear the session and bounce to login).
          if (error.response?.statusCode == 401) {
            onUnauthorized?.call();
          }
          return handler.next(error);
        },
      ),
    ]);
  }

  late final Dio _dio;
  final CancelToken _cancelToken = CancelToken();

  /// The underlying configured [Dio].
  Dio get dio => _dio;

  String? _authToken;

  /// Invoked whenever any request fails with HTTP 401. GeneralCubit registers
  /// itself here so a single place owns "session expired → log out".
  void Function()? onUnauthorized;

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  Future<Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
  }) =>
      _dio.get(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
      );

  Future<Response<dynamic>> post({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
      );

  Future<Response<dynamic>> put({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
      );

  Future<Response<dynamic>> patch({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
      );

  Future<Response<dynamic>> delete({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
      );

  void cancelAllRequests({Object? reason}) {
    _cancelToken.cancel(reason);
  }
}
