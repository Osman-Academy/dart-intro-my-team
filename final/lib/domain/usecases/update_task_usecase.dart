import '../../core/usecases/usecase.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUseCase implements UseCase<TaskEntity, TaskEntity> {
  final TaskRepository repository;
  UpdateTaskUseCase(this.repository);

  @override
  Future<TaskEntity> call(TaskEntity params) => repository.updateTask(params);
}
