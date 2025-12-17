import 'package:flutter_application_finall_project/domain/repositories/task_repository.dart';

/// Use case that deletes a task via the repository.
class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> call(int taskId) async {
    return await repository.deleteTask(taskId);
  }
}
