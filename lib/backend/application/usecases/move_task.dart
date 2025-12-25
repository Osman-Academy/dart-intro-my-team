import '../../domain/task.dart';
import '../../domain/task_repository.dart';
import '../../domain/task_status.dart';

class MoveTaskParams {
  final String taskId;
  final TaskStatus status;
  final String ownerId;
  MoveTaskParams({required this.taskId, required this.status, required this.ownerId});
}

class MoveTaskUseCase {
  final TaskRepository repository;
  MoveTaskUseCase(this.repository);

  Future<Task> call(MoveTaskParams params) {
    return repository.move(params.taskId, params.status, params.ownerId);
  }
}
