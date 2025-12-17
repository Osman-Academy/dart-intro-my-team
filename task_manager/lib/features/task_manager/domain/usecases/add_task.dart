import '../entities/task.dart';
import '../repositories/task_repository.dart';

class AddTask {
  final TaskRepository repo;
  AddTask(this.repo);

  Future<Task> call(String title) => repo.addTask(title);
}
