import '../../domain/task.dart';
import '../../domain/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;
  UpdateTaskUseCase(this.repository);

  Future<Task> call(Task task) => repository.update(task);
}
