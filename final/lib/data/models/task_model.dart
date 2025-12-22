import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/entities/task_status.dart';
import '../../domain/entities/user_entity.dart';
import 'user_model.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String title,
    required String description,
    @JsonKey(fromJson: taskStatusFromJson, toJson: taskStatusToJson) required TaskStatus status,
    required String projectId,
    UserModel? assignee,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  const TaskModel._();

  TaskEntity toEntity() => TaskEntity(
        id: id,
        title: title,
        description: description,
        status: status,
        projectId: projectId,
        assignee: assignee?.toEntity(),
      );

  static TaskModel fromEntity(TaskEntity entity) => TaskModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        status: entity.status,
        projectId: entity.projectId,
        assignee: entity.assignee != null ? UserModel.fromEntity(entity.assignee!) : null,
      );
}
