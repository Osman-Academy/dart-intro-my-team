class User {
  final int id;
  final String username;
  final String email;
  final String token;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data["id"] ?? 0,
      username: data["username"] ?? '',
      email: data["email"] ?? '',
      token: data["token"] ?? data["accessToken"] ?? '',
      firstName: data["firstName"] ?? data["firstname"] ?? '',
      lastName: data["lastName"] ?? data["lastname"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'token': token,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}