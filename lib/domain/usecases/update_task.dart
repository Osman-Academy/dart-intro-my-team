import 'package:flutter_application_finall_project/domain/entities/task.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';
import 'package:flutter_application_finall_project/domain/repositories/task_repository.dart';

/// Use case that updates an existing task via the repository.
class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<Task> call(UpdateTaskParams params) async {
    return await repository.updateTask(
      id: params.id,
      title: params.title,
      description: params.description,
      completed: params.completed,
      priority: params.priority,
      dueDate: params.dueDate,
    );
  }
}

/// Parameters for the UpdateTask use case.
class UpdateTaskParams {
  final int id;
  final String? title;
  final String? description;
  final bool? completed;
  final TaskPriority? priority;
  final DateTime? dueDate;

  UpdateTaskParams({
    required this.id,
    this.title,
    this.description,
    this.completed,
    this.priority,
    this.dueDate,
  });
}
