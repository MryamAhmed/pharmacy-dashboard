import '../../domian/entities/login_entity.dart';

/// Data-layer payload returned by the login endpoint.
class LoginData {
  final String token;
  final String? username;
  final String email;
  final String roles;
  final String expiresOn;

  const LoginData({
    required this.token,
    this.username,
    required this.email,
    required this.roles,
    required this.expiresOn,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'] as String,
      username: json['username'] as String?,
      email: json['email'] as String,
      roles: json['roles'] as String,
      expiresOn: json['expiresOn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'username': username,
      'email': email,
      'roles': roles,
      'expiresOn': expiresOn,
    };
  }

  /// Converts the backend login payload into the domain auth entity.
  AuthEntity toDomain() => AuthEntity(
        token: token,
        username: username,
        email: email,
        role: roles,
        expiresOn: DateTime.parse(expiresOn),
      );
}
