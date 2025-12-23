import 'package:uuid/uuid.dart';

import '../../domain/user.dart';
import '../../domain/user_repository.dart';

class InMemoryUserRepository implements UserRepository {
  final _users = <User>[];
  final _uuid = const Uuid();

  @override
  Future<User> create(User user) async {
    final toStore = user.id.isEmpty ? user.copyWith(id: _uuid.v4()) : user;
    _users.add(toStore);
    return toStore;
  }

  @override
  Future<User?> findByEmail(String email) async {
    try {
      return _users.firstWhere((u) => u.email.toLowerCase() == email.toLowerCase());
    } catch (_) {
      return null;
    }
  }

  @override
  Future<User?> findById(String id) async {
    try {
      return _users.firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<User>> all() async => List.unmodifiable(_users);
}
