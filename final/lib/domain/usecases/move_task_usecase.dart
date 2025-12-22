import '../../core/usecases/usecase.dart';
import '../entities/task_entity.dart';
import '../entities/task_status.dart';
import '../repositories/task_repository.dart';

class MoveTaskParams {
  final String taskId;
  final TaskStatus status;
  const MoveTaskParams({required this.taskId, required this.status});
}

class MoveTaskUseCase implements UseCase<TaskEntity, MoveTaskParams> {
  final TaskRepository repository;
  MoveTaskUseCase(this.repository);

  @override
  Future<TaskEntity> call(MoveTaskParams params) {
    return repository.moveTask(params.taskId, params.status);
  }
}
