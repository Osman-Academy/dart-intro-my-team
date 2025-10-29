class User {
  final String username;
  final String password;

  User({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json['username'],
    password: json['password'],
  );
}