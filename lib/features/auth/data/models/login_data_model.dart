import '../../../../core/constants/api_param_constatnts.dart';
import '../../domian/entities/login_entity.dart';

/// Data-layer payload returned by the login endpoint.
class LoginDataResponse {
  final String token;
  final String? username;
  final String email;
  final String roles;
  final String expiresOn;

  const LoginDataResponse({
    required this.token,
    this.username,
    required this.email,
    required this.roles,
    required this.expiresOn,
  });

  factory LoginDataResponse.fromJson(Map<String, dynamic> json) {
    return LoginDataResponse(
      token: json[ApiParamConstants.token] as String,
      username: json[ApiParamConstants.username] as String?,
      email: json[ApiParamConstants.email] as String,
      roles: json[ApiParamConstants.roles] as String,
      expiresOn: json[ApiParamConstants.expiresOn] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiParamConstants.token: token,
      ApiParamConstants.username: username,
      ApiParamConstants.email: email,
      ApiParamConstants.roles: roles,
      ApiParamConstants.expiresOn: expiresOn,
    };
  }

  /// Converts the backend login payload into the domain auth entity.
  AuthEntity toDomain() => AuthEntity(
    token: token,
    username: username,
    email: email,
    role: roles,
    expiresOn: expiresOn,
  );
}
