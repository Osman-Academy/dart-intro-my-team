import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository repo;
  UpdateTask(this.repo);

  Future<Task> call(Task task) => repo.updateTask(task);
}
