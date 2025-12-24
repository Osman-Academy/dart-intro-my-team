
import 'package:injectable/injectable.dart';
import 'package:string_search_app/domain/entities/user.dart';
import 'package:string_search_app/domain/repositories/user_repository.dart';

@injectable
class SearchUsers {
  final UserRepository repository;

  SearchUsers(this.repository);

  Future<List<User>> call(String pattern) async {
    final users = await repository.getUsers();
    return users
        .where((u) => u.name.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }
}
