import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
  Future<UserEntity?> getById(String id);

  Future<UserEntity> create(UserEntity user);
}
