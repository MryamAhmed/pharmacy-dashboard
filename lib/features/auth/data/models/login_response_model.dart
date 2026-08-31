import 'package:pharmacy_app/features/auth/data/models/login_data_model.dart';
import 'package:pharmacy_app/features/auth/domian/entities/login_entity.dart';

/// Data-layer response envelope returned by the login endpoint.
class LoginResponse {
  final String message;
  final bool success;
  final LoginData data;

  const LoginResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] as String,
      success: json['success'] as bool,
      data: LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'data': data.toJson(),
    };
  }

  /// Converts the successful login response into the app's auth entity.
  AuthEntity toDomain() => data.toDomain();
}
