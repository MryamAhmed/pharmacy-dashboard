// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import '../../../core/constants/app_error_codes.dart';
import '../../domain/entities/app_error.dart';

/// Data-layer failure type returned by data sources via `Either<Failure, T>`.
/// Repositories map this to [AppError] before crossing into the domain layer.
class Failure {
  const Failure({
    this.code,
    this.statusCode,
    this.isNetwork = false,
    this.fieldErrors,
    this.message,
  });

  final String? code;

  /// Human-readable error string from the backend (e.g. a bare-string body).
  final String? message;

  final int? statusCode;
  final bool isNetwork;

  /// Per-field validation messages captured from 400 responses whose body is
  /// a flat `{ "fieldName": "message" }` map.
  final Map<String, String>? fieldErrors;

  factory Failure.local(String code) => Failure(code: code);

  factory Failure.fromException(Object e) {
    if (e is DioException && e.response != null) {
      return Failure.fromResponse(e.response!);
    }
    return const Failure(isNetwork: true);
  }

  factory Failure.fromResponse(Response<dynamic> r) {
    String? code;
    String? message;
    Map<String, String>? fieldErrors;
    final data = r.data;

    //json => "Invalid email"
    if (data is String && data.trim().isNotEmpty) {
      // Bare-string error body — the entire response is the error message.
      message = data.trim();
    } else if (data is Map<String, dynamic>) {
      ////{"success": false,"data": "Invalid email"}
      if (data['success'] == false) {
        // Standard envelope: { "success": false, "data": "ERROR_CODE" } or
        // { "success": false, "message": "..." }.
        if (data['data'] is String) {
          code = data['data'] as String;
          message = code;
      ////{"success": false,"message": "Invalid email"}
        } else if (data['message'] is String) {
          message = data['message'] as String;
        }
      } 
      //{"username": "Username is required","email": "Invalid email"} and fieldErrors = { "username": "Username is required","email": "Invalid email",};
      else if (r.statusCode == 400 || r.statusCode == 422) { 
        // Flat field-validation map: { "username": "...", "email": "..." }
        // Values may be a plain String or a List<String> (multiple messages per
        // field). All messages are joined with '\n' so the UI can display them.
        final flat = <String, String>{};
        data.forEach((key, value) {
          if (value is String) {
            flat[key] = value;
          } else if (value is List) {
            final joined = value.whereType<String>().join('\n');
            if (joined.isNotEmpty) flat[key] = joined;
          }
        });
        if (flat.isNotEmpty) {
          fieldErrors = flat;
          message = flat.values.join('\n');
        }
      }
    }

    // 409 Conflict always means the email is already registered, regardless of
    // the response body.
    if (r.statusCode == 409) {
      code = AppErrorCodes.emailAlreadyRegistered;
    }

    return Failure(
      code: code,
      message: message,
      statusCode: r.statusCode,
      fieldErrors: fieldErrors,
    );
  }

  AppError toAppError() => AppError(
        code: code,
        statusCode: statusCode,
        isNetwork: isNetwork,
        fieldErrors: fieldErrors,
        message: message,
      );
}
