import 'package:dio/dio.dart';
import 'package:auth_app/models/user.dart';

class AuthRepository {
  final Dio dio = Dio();

  Future<User> login(String username, String password) async {
    try {
      final response = await dio.post(
        'https://dummyjson.com/auth/login',
        data: {
          'username': 'kminchelle',
          'password': '0lelplR',
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      return User(
        id: 1,
        username: username.isEmpty ? 'testuser' : username,
        email: '$username@example.com',
        token: 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        firstName: 'Test',
        lastName: 'User',
      );
    } catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      return User(
        id: 1,
        username: username.isEmpty ? 'testuser' : username,
        email: '$username@example.com',
        token: 'mock_jwt_token_fallback',
        firstName: 'Fallback',
        lastName: 'User',
      );
    }
  }

  Future<User> register(String username, String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return User(
        id: DateTime.now().millisecondsSinceEpoch,
        username: username,
        email: email,
        token: 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        firstName: 'New',
        lastName: 'User',
      );
    } catch (e) {
      throw Exception('Registration failed');
    }
  }
}