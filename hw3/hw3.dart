import 'dart:io';

void runHW3() {
  Map<String, String> users = {
    "admin": "1234",
    "user": "pass"
  };

  print("Hw 3: Auth Login Logic");

  stdout.write("Enter username: ");
  String? username = stdin.readLineSync();

  stdout.write("Enter password: ");
  String? password = stdin.readLineSync();

  if (username != null && password != null) {
    if (users.containsKey(username) && users[username] == password) {
      print("Login successful! Welcome, $username!");
    } else {
      print("Invalid username or password.");
    }
  } else {
    print("Please enter both username and password.");
  }
}
