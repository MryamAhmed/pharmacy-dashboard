import 'package:pharmacy_app/features/auth/data/models/login_data_model.dart';

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
}