import 'package:flutter/foundation.dart';
import '../repositories/auth_repository.dart';

class AuthService extends ChangeNotifier {
  final AuthRepository _repo;
  String? _token;
  String? get token => _token;
  bool get isAuthenticated => _token != null;

  AuthService(this._repo);

  Future<bool> login(String email, String password) async {
    final t = await _repo.login(email.trim(), password);
    if (t != null) {
      _token = t;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _repo.logout();
    _token = null;
    notifyListeners();
  }
}
