import 'user.dart';

abstract class UserRepository {
  Future<User?> findByEmail(String email);
  Future<User?> findById(String id);
  Future<User> create(User user);
  Future<List<User>> all();
}
