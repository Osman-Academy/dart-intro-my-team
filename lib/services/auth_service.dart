import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

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
    final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
    final accessToken = data['accessToken'] as String?;
    final refreshToken = data['refreshToken'] as String?;
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Сервер не вернул accessToken. Ответ: $data');
    }
    final user = await fetchCurrentUser(accessToken);
    return <String, dynamic>{
      'token': accessToken,
      'refreshToken': refreshToken ?? '',
      'user': user.toJson(),
    };
  }

  Future<User> fetchCurrentUser(String token) async {
    final uri = Uri.parse(_baseUrl + '/user/me');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      throw Exception('Ошибка получения пользователя: ${response.statusCode}: ${response.body}');
    }
    final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
    return User.fromJson(data);
  }
}
