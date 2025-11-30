import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

/// Auth service using DummyJSON-like API.
/// Пример ответа:
/// {
///   "id": 1,
///   "username": "emilys",
///   "email": "emily.johnson@x.dummyjson.com",
///   "firstName": "Emily",
///   "lastName": "Johnson",
///   "gender": "female",
///   "image": "https://dummyjson.com/icon/emilys/128",
///   "accessToken": "<jwt>",
///   "refreshToken": "<jwt>"
/// }
class AuthService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final uri = Uri.parse(_baseUrl + '/auth/login');

    final response = await http.post(
      uri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка входа: ${response.statusCode}: ${response.body}');
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;

    // Новая схема: accessToken/refreshToken
    final accessToken = data['accessToken'] as String?;
    final refreshToken = data['refreshToken'] as String?;

    // Собираем пользователя из ответа
    final user = User(
      id: (data['id'] ?? '').toString(),
      email: (data['email'] ?? '') as String,
      name: (data['firstName'] ?? data['username'] ?? '') as String,
    );

    return <String, dynamic>{
      // Для совместимости вернём 'token' как accessToken
      'token': accessToken ?? '',
      'refreshToken': refreshToken ?? '',
      'user': user.toJson(),
      'raw': data,
    };
  }

  Future<User> fetchCurrentUser(String token) async {
    throw UnimplementedError('fetchCurrentUser не реализован для DummyJSON');
  }
}
