import 'package:flutter_application_finall_project/domain/entities/task.dart';
import 'package:flutter_application_finall_project/domain/repositories/task_repository.dart';

/// Use case that returns a list of tasks by delegating to the repository.
class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.getTasks();
  }
}
