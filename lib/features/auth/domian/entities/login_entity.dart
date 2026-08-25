class AuthEntity {
  final String token;
  final String? username;
  final String email;
  final String role;
  final DateTime expiresOn;

  const AuthEntity({
    required this.token,
    this.username,
    required this.email,
    required this.role,
    required this.expiresOn,
  });
}