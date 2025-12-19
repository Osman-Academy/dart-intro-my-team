import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SearchUsersUseCase {
  final UserRepository repository;

  SearchUsersUseCase(this.repository);

  List<User> call(String query) {
    return repository.search(query);
  }
}
