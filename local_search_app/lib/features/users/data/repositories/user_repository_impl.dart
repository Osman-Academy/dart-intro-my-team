import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final List<User> _users = const [
    User(id: 1, name: 'Iskhak Asanov', email: 'iskhak@mail.com'),
    User(id: 2, name: 'Asan Ymytov', email: 'asan@mail.com'),
    User(id: 3, name: 'Ymut Uitov', email: 'ymut@mail.com'),
    User(id: 4, name: 'David Akya', email: 'david@mail.com'),
  ];

  @override
  List<User> getUsers() => _users;
}
