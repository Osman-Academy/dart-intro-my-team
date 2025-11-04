import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String password; 
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJsonWithoutPassword() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
