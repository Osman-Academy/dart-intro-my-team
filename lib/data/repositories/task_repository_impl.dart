import 'package:flutter_application_finall_project/data/datasources/task_remote_datasource.dart';
import 'package:flutter_application_finall_project/data/models/task_model.dart';
import 'package:flutter_application_finall_project/domain/entities/task.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';
import 'package:flutter_application_finall_project/domain/repositories/task_repository.dart';

/// Implementation of [TaskRepository] that uses a remote data source.
class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Task>> getTasks() async {
    final models = await remoteDataSource.fetchTasks();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Task> addTask({
    required String title,
    required String description,
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
  }) async {
    final model = await remoteDataSource.createTask(
      title: title,
      description: description,
      priority: priority.toStringValue(),
      dueDate: dueDate?.toIso8601String(),
    );
    return model.toEntity();
  }

  @override
  Future<Task> updateTask({
    required int id,
    String? title,
    String? description,
    bool? completed,
    TaskPriority? priority,
    DateTime? dueDate,
  }) async {
    final model = await remoteDataSource.updateTask(
      id: id,
      title: title,
      description: description,
      completed: completed,
      priority: priority?.toStringValue(),
      dueDate: dueDate?.toIso8601String(),
    );
    return model.toEntity();
  }

  @override
  Future<void> deleteTask(int taskId) async {
    await remoteDataSource.deleteTask(taskId);
  }
}
