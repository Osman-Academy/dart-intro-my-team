import '../../domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };

  UserEntity toEntity() => UserEntity(id: id, name: name, email: email);

  static UserModel fromEntity(UserEntity entity) =>
      UserModel(id: entity.id, name: entity.name, email: entity.email);
}
