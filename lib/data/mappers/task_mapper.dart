import '../../domain/entities/task_entity.dart';
import '../models/task_model.dart';

class TaskMapper {
  static TaskEntity toEntity(TaskModel model) => model.toEntity();

  static TaskModel toModel(TaskEntity entity) => TaskModel.fromEntity(entity);
}
