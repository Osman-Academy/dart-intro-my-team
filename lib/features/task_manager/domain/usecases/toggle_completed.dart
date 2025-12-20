import '../entities/task.dart';
import '../repositories/task_repository.dart';

class ToggleCompleted {
  final TaskRepository repo;
  ToggleCompleted(this.repo);

  Future<Task> call(String id) => repo.toggleCompleted(id);
}
