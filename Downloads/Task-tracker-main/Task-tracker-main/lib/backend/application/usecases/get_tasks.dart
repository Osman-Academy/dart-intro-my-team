import '../../domain/task.dart';
import '../../domain/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;
  GetTasksUseCase(this.repository);

  Future<List<Task>> call(String ownerId) => repository.findAll(ownerId);
}
