import 'dart:math';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _dataSource;

  TaskRepositoryImpl(this._dataSource);

  @override
  Future<List<Task>> getTasks() async {
    return await _dataSource.getTasks();
  }

  @override
  Future<Task> addTask(Task task) async {
    final newTask = task.copyWith(
      id: _generateId(),
      createdAt: DateTime.now(),
    );
    return await _dataSource.addTask(newTask);
  }

  @override
  Future<Task> updateTask(Task task) async {
    return await _dataSource.updateTask(
      task.copyWith(updatedAt: DateTime.now()),
    );
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await _dataSource.deleteTask(taskId);
  }

  @override
  Future<List<Task>> refreshTasks() async {
    return await getTasks();
  }


  @override
  Future<void> toggleTaskCompletion(String taskId) async {
    await _dataSource.toggleTaskCompletion(taskId);
  }

  @override
  Future<List<Task>> searchTasks(String query) async {
    return await _dataSource.searchTasks(query);
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() + 
           Random().nextInt(1000).toString();
  }
}
