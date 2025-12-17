import 'package:flutter_application_finall_project/domain/entities/task.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';
import 'package:flutter_application_finall_project/domain/repositories/task_repository.dart';

/// Use case that adds a new task via the repository.
class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<Task> call(AddTaskParams params) async {
    return await repository.addTask(
      title: params.title,
      description: params.description,
      priority: params.priority,
      dueDate: params.dueDate,
    );
  }
}

/// Parameters for the AddTask use case.
class AddTaskParams {
  final String title;
  final String description;
  final TaskPriority priority;
  final DateTime? dueDate;

  AddTaskParams({
    required this.title,
    required this.description,
    this.priority = TaskPriority.medium,
    this.dueDate,
  });
}
