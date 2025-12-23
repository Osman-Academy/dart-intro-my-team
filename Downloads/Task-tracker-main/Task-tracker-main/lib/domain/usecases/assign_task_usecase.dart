import '../../core/usecases/usecase.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class AssignTaskParams {
  final String taskId;
  final String userId;
  const AssignTaskParams({required this.taskId, required this.userId});
}

class AssignTaskUseCase implements UseCase<TaskEntity, AssignTaskParams> {
  final TaskRepository repository;
  AssignTaskUseCase(this.repository);

  @override
  Future<TaskEntity> call(AssignTaskParams params) {
    return repository.assignTask(params.taskId, params.userId);
  }
}
