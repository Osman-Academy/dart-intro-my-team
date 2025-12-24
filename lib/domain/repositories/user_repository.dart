import 'package:string_search_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
}
