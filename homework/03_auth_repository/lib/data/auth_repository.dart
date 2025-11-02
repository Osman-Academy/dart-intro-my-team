class AuthRepository {
  bool _loggedIn = false;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == "test@example.com" && password == "123") {
      _loggedIn = true;
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _loggedIn = false;
  }

  bool get isLoggedIn => _loggedIn;
}
