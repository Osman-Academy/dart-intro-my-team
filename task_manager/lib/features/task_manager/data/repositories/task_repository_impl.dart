import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasource/task_remote_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDatasource remote;

  TaskRepositoryImpl(this.remote);

  List<Task> _cache = const [];

  @override
  Future<List<Task>> getTasks() async {
    final List<TaskModel> models = await remote.fetchTasks();
    _cache = models.map((m) => m.toEntity()).toList();
    return _cache;
  }

  @override
  Future<List<Task>> searchTasks(String pattern) async {
    if (_cache.isEmpty) {
      await getTasks();
    }

    final q = pattern.trim().toLowerCase();
    if (q.isEmpty) return _cache;

    return _cache.where((t) => t.title.toLowerCase().contains(q)).toList();
  }

    @override
  Future<Task> addTask(String title) async {
    final created = await remote.createTask(title);
    final entity = created.toEntity();
    _cache = [entity, ..._cache];
    return entity;
  }

  @override
  Future<Task> updateTask(Task task) async {
    final updated = await remote.updateTask(TaskModel(
      id: task.id,
      title: task.title,
      completed: task.completed,
    ));
    final entity = updated.toEntity();
    _cache = _cache.map((t) => t.id == entity.id ? entity : t).toList();
    return entity;
  }

  @override
  Future<void> deleteTask(String id) async {
    await remote.deleteTask(id);
    _cache = _cache.where((t) => t.id != id).toList();
  }

@override
  Future<Task> toggleCompleted(String id) async {
    final current = _cache.firstWhere((t) => t.id == id);

    final updated = await remote.updateTask(TaskModel(
      id: current.id,
      title: current.title,
      completed: !current.completed,
    ));

    final entity = updated.toEntity();
    _cache = _cache.map((t) => t.id == id ? entity : t).toList();
    return entity;
  }


}
