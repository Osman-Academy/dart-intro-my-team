import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

import '../../domain/user.dart';
import '../../domain/user_repository.dart';
import '../../domain/user_role.dart';

class PostgresUserRepository implements UserRepository {
  final Connection _conn;
  bool _initialized = false;

  PostgresUserRepository(this._conn);

  Future<void> ensureInitialized() async {
    if (_initialized) return;
    await _conn.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id UUID PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        role TEXT NOT NULL,
        password_hash TEXT NOT NULL,
        avatar_url TEXT
      );
    ''');
    _initialized = true;
  }

  @override
  Future<User> create(User user) async {
    await ensureInitialized();
    final id = user.id.isNotEmpty ? user.id : const Uuid().v4();
    await _conn.execute(
      Sql.named('INSERT INTO users (id, name, email, role, password_hash, avatar_url) VALUES (@id, @name, @email, @role, @password, @avatar)'),
      parameters: {
        'id': id,
        'name': user.name,
        'email': user.email,
        'role': user.role.value,
        'password': user.passwordHash,
        'avatar': user.avatarUrl,
      },
    );
    return user.copyWith(id: id);
  }

  @override
  Future<User?> findByEmail(String email) async {
    await ensureInitialized();
    final res = await _conn.execute(
      Sql.named('SELECT id, name, email, role, password_hash, avatar_url FROM users WHERE LOWER(email) = LOWER(@email) LIMIT 1'),
      parameters: {'email': email},
    );
    if (res.isEmpty) return null;
    return _mapRow(res.first);
  }

  @override
  Future<User?> findById(String id) async {
    await ensureInitialized();
    final res = await _conn.execute(
      Sql.named('SELECT id, name, email, role, password_hash, avatar_url FROM users WHERE id = @id LIMIT 1'),
      parameters: {'id': id},
    );
    if (res.isEmpty) return null;
    return _mapRow(res.first);
  }

  @override
  Future<List<User>> all() async {
    await ensureInitialized();
    final res = await _conn.execute(
      Sql.named('SELECT id, name, email, role, password_hash, avatar_url FROM users'),
    );
    return res.map(_mapRow).toList();
  }

  User _mapRow(ResultRow row) {
    return User(
      id: row[0] as String,
      name: row[1] as String,
      email: row[2] as String,
      role: UserRole.parse(row[3] as String),
      passwordHash: row[4] as String,
      avatarUrl: row[5] as String?,
    );
  }
}
