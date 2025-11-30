import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

/// Auth service using DummyJSON API.
/// Docs: https://dummyjson.com/docs/auth
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
      // DummyJSON возвращает 400 при неверных данных
      throw Exception('Ошибка входа: ${response.statusCode}');
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;

    /* Пример ответа DummyJSON:
      {
        "id": 1,
        "username": "kminchelle",
        "email": "kminchelle@qq.com",
        "firstName": "Jeanne",
        "lastName": "Halvorson",
        "token": "..."
      }
    */

    final token = data['token'] as String?;
    if (token == null) {
      throw Exception('Некорректный ответ сервера (нет token)');
    }

    final user = User.fromJson(data);

    return <String, dynamic>{
      'token': token,
      'user': user.toJson(),
    };
  }

  // Заглушка, если позже захочешь получать текущего пользователя по токену.
  Future<User> fetchCurrentUser(String token) async {
    // В DummyJSON нет отдельного эндпоинта для текущего пользователя по токену,
    // поэтому тут можно просто вернуть локально сохранённого пользователя
    // или сделать запрос к своему backend, если он появится.
    throw UnimplementedError('fetchCurrentUser не реализован для DummyJSON');
  }
}
