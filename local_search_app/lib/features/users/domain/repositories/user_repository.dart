import '../entities/user.dart';

abstract class UserRepository {
  /// Возвращает список всех пользователей
  List<User> getUsers();
}
