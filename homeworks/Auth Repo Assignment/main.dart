class User {
  final String email;
  final String password;

  User(this.email, this.password);
}

class AuthRepository {
  final List<User> _users = [
    User('1dohnjoe@gmail.com', '12345'),
    User('dohnjoe@gmail.com', 'pass123'),
    User('admin@gmail.com', 'admin'),
  ];

  User? login(String email, String password) {
    for (var user in _users) {
      if (user.email == email && user.password == password) {
        print('Login successful: ${user.email}');
        return user;
      }
    }
    print('Invalid credentials');
    return null;
  }

  void register(String email, String password) {
    _users.add(User(email, password));
    print('User registered: $email');
  }
}

void main() {
  final repo = AuthRepository();

  repo.register('dohnjoe@mail.com', 'pass123');
  repo.login('dohnjoe@mail.com', 'pass123');
  repo.login('wrong@mail.com', 'test');
}
