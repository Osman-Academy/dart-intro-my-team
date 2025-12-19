import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final List<User> _users = [
    User(id: 1, name: 'Iskhak'),
    User(id: 2, name: 'Adeliya'),
    User(id: 3, name: 'Saltanat'),
    User(id: 4, name: 'Iskander'),
  ];

  @override
  List<User> search(String query) {
    if (query.isEmpty) return _users;
    return _users
        .where((u) =>
            u.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
