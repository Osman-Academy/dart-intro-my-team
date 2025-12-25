import '../../domain/task.dart';
import '../../domain/task_repository.dart';
import '../../domain/task_status.dart';

class InMemoryTaskRepository implements TaskRepository {
  final _items = <Task>[];

  @override
  Future<Task> assign(String taskId, String? userId, String ownerId) async {
    final existing = await findById(taskId, ownerId);
    if (existing == null) {
      throw StateError('Task not found');
    }
    final updated = existing.copyWith(assigneeId: userId);
    return update(updated, ownerId);
  }

  @override
  Future<Task> create(Task task) async {
    _items.add(task);
    return task;
  }

  @override
  Future<List<Task>> findAll(String ownerId) async =>
      List.unmodifiable(_items.where((t) => t.ownerId == ownerId));

  @override
  Future<Task?> findById(String id, String ownerId) async {
    try {
      return _items.firstWhere((t) => t.id == id && t.ownerId == ownerId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Task> move(String taskId, TaskStatus status, String ownerId) async {
    final existing = await findById(taskId, ownerId);
    if (existing == null) throw StateError('Task not found');
    final updated = existing.copyWith(status: status);
    return update(updated, ownerId);
  }

  @override
  Future<Task> update(Task task, String ownerId) async {
    final idx = _items.indexWhere((t) => t.id == task.id && t.ownerId == ownerId);
    if (idx == -1) throw StateError('Task not found');
    _items[idx] = task;
    return task;
  }
}
