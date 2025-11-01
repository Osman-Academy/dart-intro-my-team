class AccountRepo  {
  final Map <String, String> _accounts = {
    'test': 'test',
    'example@email.com': 'password',
    'admin@email.com' : 'admin123',
  };

  bool authenticate(String username, String password) {
    return _accounts[username] == password;
  }
}