import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'user.dart';

class AuthService {
  final Map<String, String> _store = {};
  User? _current;

  String _hash(String input) => sha256.convert(utf8.encode(input)).toString();

  void register(String username, String password) {
    if (_store.containsKey(username)) throw StateError('user exists');
    _store[username] = _hash(password);
  }

  User login(String username, String password) {
    final h = _hash(password);
    final stored = _store[username];
    if (stored == null || stored != h) throw StateError('invalid credentials');
    _current = User(username: username, passwordHash: stored);
    return _current!;
  }

  void logout() {
    _current = null;
  }

  User? get currentUser => _current;

  bool get isAuthenticated => _current != null;
}
