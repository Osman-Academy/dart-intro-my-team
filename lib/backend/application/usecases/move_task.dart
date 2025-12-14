import '../../domain/task.dart';
import '../../domain/task_repository.dart';
import '../../domain/task_status.dart';

class MoveTaskParams {
  final String taskId;
  final TaskStatus status;
  MoveTaskParams({required this.taskId, required this.status});
}

class MoveTaskUseCase {
  final TaskRepository repository;
  MoveTaskUseCase(this.repository);

  Future<Task> call(MoveTaskParams params) {
    return repository.move(params.taskId, params.status);
  }
}
