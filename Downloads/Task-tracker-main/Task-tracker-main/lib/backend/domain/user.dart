import 'user_role.dart';

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String passwordHash;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.passwordHash,
    this.avatarUrl,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    String? passwordHash,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      passwordHash: passwordHash ?? this.passwordHash,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
