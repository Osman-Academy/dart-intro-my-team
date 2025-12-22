import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class InMemoryUserRepository implements UserRepository {
  final List<User> _storage = [
    const User(
        id: 1,
        name: 'Alice Johnson',
        email: 'alice@example.com',
        phone: '+1 555 0101',
        role: 'Designer'),
    const User(
        id: 2,
        name: 'Bob Smith',
        email: 'bob@example.com',
        phone: '+1 555 0102',
        role: 'Developer'),
    const User(
        id: 3,
        name: 'Carlos Rodriguez',
        email: 'carlos@example.com',
        phone: '+1 555 0103',
        role: 'Product'),
  ];

  @override
  Future<void> addUser(User user) async {
    _storage.add(user);
  }

  @override
  Future<void> deleteUser(int id) async {
    _storage.removeWhere((u) => u.id == id);
  }

  @override
  Future<List<User>> getUsers() async {
    // return copy to avoid external mutation
    return List<User>.from(_storage);
  }

  @override
  Future<void> updateUser(User user) async {
    final idx = _storage.indexWhere((u) => u.id == user.id);
    if (idx >= 0) _storage[idx] = user;
  }
}
