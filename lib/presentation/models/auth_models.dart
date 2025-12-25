import '../blocs/auth_bloc/auth_state.dart';

class AuthUserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? avatarUrl;

  AuthUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        role: json['role'] as String? ?? 'developer',
        avatarUrl: json['avatarUrl'] as String?,
      );

  AuthUser toEntity() => AuthUser(
        id: id,
        name: name,
        email: email,
        role: role,
        avatarUrl: avatarUrl,
      );
}
