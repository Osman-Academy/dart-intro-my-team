import '../../domain/task.dart';
import '../../domain/task_repository.dart';

class AssignTaskParams {
  final String taskId;
  final String? userId;
  final String ownerId;
  AssignTaskParams({required this.taskId, required this.userId, required this.ownerId});
}

class AssignTaskUseCase {
  final TaskRepository repository;
  AssignTaskUseCase(this.repository);

  Future<Task> call(AssignTaskParams params) {
    return repository.assign(params.taskId, params.userId, params.ownerId);
  }
}
