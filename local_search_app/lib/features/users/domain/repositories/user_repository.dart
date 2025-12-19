import '../entities/user.dart';

abstract class UserRepository {
  List<User> search(String query);
}
