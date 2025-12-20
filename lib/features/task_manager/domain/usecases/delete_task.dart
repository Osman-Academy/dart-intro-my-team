import '../repositories/task_repository.dart';

class DeleteTask {
  final TaskRepository repo;
  DeleteTask(this.repo);

  Future<void> call(String id) => repo.deleteTask(id);
}
