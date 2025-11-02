class User {
  String username;
  String password;

  User(this.username, this.password);
}

class AuthRepository {
  final List<User> _users = [];

  void register(String username, String password) {
    if (_users.any((u) => u.username == username)) {
      print("⚠️ User already exists!");
    } else {
      _users.add(User(username, password));
      print("✅ User $username registered!");
    }
  }

  bool login(String username, String password) {
    for (var user in _users) {
      if (user.username == username && user.password == password) {
        print("🔓 Login successful for $username");
        return true;
      }
    }
    print("❌ Invalid credentials!");
    return false;
  }
}

void main() {
  var repo = AuthRepository();

  repo.register("alice", "1234");
  repo.register("bob", "abcd");

  repo.login("alice", "1234");
  repo.login("bob", "wrong");
}
