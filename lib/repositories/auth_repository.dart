class AuthRepository {
  Future<String?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (email.isNotEmpty && password.isNotEmpty) {
      return 'token_${email.hashCode}_${DateTime.now().millisecondsSinceEpoch}';
    }
    return null;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return;
  }
}
