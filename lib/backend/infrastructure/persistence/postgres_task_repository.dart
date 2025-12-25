import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

import '../../domain/task.dart';
import '../../domain/task_repository.dart';
import '../../domain/task_status.dart';

class PostgresTaskRepository implements TaskRepository {
  final Connection _conn;
  bool _initialized = false;

  PostgresTaskRepository(this._conn);

  Future<void> ensureInitialized() async {
    if (_initialized) return;
    await _conn.execute('''
      CREATE TABLE IF NOT EXISTS tasks (
        id UUID PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT DEFAULT '',
        status TEXT NOT NULL,
        project_id TEXT NOT NULL,
        assignee_id UUID,
        owner_id UUID
      );
    ''');
    // Reset legacy column with invalid default/values
    await _conn.execute(Sql.named("ALTER TABLE tasks DROP COLUMN IF EXISTS owner_id"));
    await _conn.execute(Sql.named("ALTER TABLE tasks ADD COLUMN owner_id UUID"));
    _initialized = true;
  }

  @override
  Future<Task> create(Task task) async {
    await ensureInitialized();
    final id = task.id.isNotEmpty ? task.id : const Uuid().v4();
    await _conn.execute(
      Sql.named(
          'INSERT INTO tasks (id, title, description, status, project_id, assignee_id, owner_id) VALUES (@id, @title, @description, @status, @project, @assignee, @owner)'),
      parameters: {
        'id': id,
        'title': task.title,
        'description': task.description,
        'status': task.status.name,
        'project': task.projectId,
        'assignee': task.assigneeId,
        'owner': task.ownerId,
      },
    );
    return task.copyWith(id: id);
  }

  @override
  Future<List<Task>> findAll(String ownerId) async {
    await ensureInitialized();
    final res = await _conn.execute(
      Sql.named(
          'SELECT id, title, description, status, project_id, assignee_id, owner_id FROM tasks WHERE owner_id = @owner'),
      parameters: {'owner': ownerId},
    );
    return res.map(_mapRow).toList();
  }

  @override
  Future<Task?> findById(String id, String ownerId) async {
    await ensureInitialized();
    final res = await _conn.execute(
      Sql.named(
          'SELECT id, title, description, status, project_id, assignee_id, owner_id FROM tasks WHERE id = @id AND owner_id = @owner LIMIT 1'),
      parameters: {'id': id, 'owner': ownerId},
    );
    if (res.isEmpty) return null;
    return _mapRow(res.first);
  }

  @override
  Future<Task> update(Task task, String ownerId) async {
    await ensureInitialized();
    await _conn.execute(
      Sql.named(
          'UPDATE tasks SET title=@title, description=@description, status=@status, project_id=@project, assignee_id=@assignee WHERE id=@id AND owner_id=@owner'),
      parameters: {
        'id': task.id,
        'title': task.title,
        'description': task.description,
        'status': task.status.name,
        'project': task.projectId,
        'assignee': task.assigneeId,
        'owner': ownerId,
      },
    );
    return task;
  }

  @override
  Future<Task> move(String taskId, TaskStatus status, String ownerId) async {
    final existing = await findById(taskId, ownerId);
    if (existing == null) throw StateError('Task not found');
    final updated = existing.copyWith(status: status);
    return update(updated, ownerId);
  }

  @override
  Future<Task> assign(String taskId, String? userId, String ownerId) async {
    final existing = await findById(taskId, ownerId);
    if (existing == null) throw StateError('Task not found');
    final updated = existing.copyWith(assigneeId: userId);
    return update(updated, ownerId);
  }

  Task _mapRow(ResultRow row) {
    return Task(
      id: row[0] as String,
      title: row[1] as String,
      description: row[2] as String? ?? '',
      status: _parseStatus(row[3] as String?),
      projectId: row[4] as String,
      assigneeId: row[5] as String?,
      ownerId: row[6] as String? ?? '',
    );
  }

  TaskStatus _parseStatus(String? value) {
    if (value == null) return TaskStatus.todo;
    final normalized = value.replaceAll('-', '_').toLowerCase();
    return TaskStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == normalized,
      orElse: () => TaskStatus.todo,
    );
  }
}
