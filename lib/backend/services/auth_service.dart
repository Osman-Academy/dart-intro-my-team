import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../domain/user.dart';

class AuthService {
  AuthService({String? jwtSecret})
      : _secretKey = SecretKey(jwtSecret ?? 'dev-secret-change-me');

  final SecretKey _secretKey;

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  bool verifyPassword(String password, String hash) {
    return hashPassword(password) == hash;
  }

  String signToken(User user) {
    final jwt = JWT({
      'sub': user.id,
      'name': user.name,
      'email': user.email,
      'role': user.role.name,
    });
    return jwt.sign(_secretKey, expiresIn: const Duration(hours: 12));
  }

  JWT? verifyToken(String token) {
    try {
      return JWT.verify(token, _secretKey);
    } catch (_) {
      return null;
    }
  }
}
