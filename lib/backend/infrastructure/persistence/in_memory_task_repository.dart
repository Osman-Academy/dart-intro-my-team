import '../../domain/task.dart';
import '../../domain/task_repository.dart';
import '../../domain/task_status.dart';

class InMemoryTaskRepository implements TaskRepository {
  final _items = <Task>[];

  @override
  Future<Task> assign(String taskId, String? userId) async {
    final existing = await findById(taskId);
    if (existing == null) {
      throw StateError('Task not found');
    }
    final updated = existing.copyWith(assigneeId: userId);
    return update(updated);
  }

  @override
  Future<Task> create(Task task) async {
    _items.add(task);
    return task;
  }

  @override
  Future<List<Task>> findAll() async => List.unmodifiable(_items);

  @override
  Future<Task?> findById(String id) async {
    try {
      return _items.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Task> move(String taskId, TaskStatus status) async {
    final existing = await findById(taskId);
    if (existing == null) throw StateError('Task not found');
    final updated = existing.copyWith(status: status);
    return update(updated);
  }

  @override
  Future<Task> update(Task task) async {
    final idx = _items.indexWhere((t) => t.id == task.id);
    if (idx == -1) throw StateError('Task not found');
    _items[idx] = task;
    return task;
  }
}
