class User {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String name;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? '';
    final username = json['username'] ?? '';
    final email = json['email'] ?? '';
    final firstName = json['firstName'] ?? '';
    final lastName = json['lastName'] ?? '';
    final gender = json['gender'] ?? '';
    final image = json['image'] ?? '';
    final derivedName = firstName.isNotEmpty ? firstName : (json['name'] ?? username);
    return User(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      image: image,
      name: derivedName,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'image': image,
        'name': name,
      };
}
