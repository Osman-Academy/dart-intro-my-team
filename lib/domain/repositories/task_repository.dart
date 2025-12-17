import 'package:flutter_application_finall_project/domain/entities/task.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';

/// Repository interface in the domain layer exposing task-fetching and CRUD operations.
abstract class TaskRepository {
  /// Returns a list of tasks or throws an exception on failure.
  Future<List<Task>> getTasks();

  /// Adds a new task and returns the created task with its server ID.
  Future<Task> addTask({
    required String title,
    required String description,
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
  });

  /// Updates an existing task by ID. Only provided fields are updated.
  Future<Task> updateTask({
    required int id,
    String? title,
    String? description,
    bool? completed,
    TaskPriority? priority,
    DateTime? dueDate,
  });

  /// Deletes a task by its ID.
  Future<void> deleteTask(int taskId);
}
