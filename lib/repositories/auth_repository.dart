class User {
  final String username;
  final String password;

  User(this.username, this.password);
}

class AuthRepository {
  final List<User> _users = [
    User('admin', '1234'),
    User('user', 'abcd'),
  ];

  bool login(String username, String password) {
    for (var user in _users) {
      if (user.username == username && user.password == password) {
        print(' Login successful for $username');
        return true;
      }
    }
    print(' Login failed: wrong credentials');
    return false;
  }
}

void main() {
  final repo = AuthRepository();
  repo.login('admin', '1234'); 
  repo.login('user', 'wrong');
}
