import 'dart:async';

class AuthRepository {
  String? _token;

  Future<String> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // имитация запроса
    if (username == 'user' && password == '1234') {
      _token = 'token_${DateTime.now().millisecondsSinceEpoch}';
      return _token!;
    } else {
      throw Exception('Неверный логин или пароль');
    }
  }

  Future<void> logout() async {
    _token = null;
  }

  bool isLoggedIn() => _token != null;
}
