import 'package:freezed_annotation/freezed_annotation.dart';

import 'task_status.dart';
import 'user_entity.dart';

part 'task_entity.freezed.dart';
part 'task_entity.g.dart';

@freezed
class TaskEntity with _$TaskEntity {
  const factory TaskEntity({
    required String id,
    required String title,
    required String description,
    @JsonKey(fromJson: taskStatusFromJson, toJson: taskStatusToJson) required TaskStatus status,
    required String projectId,
    UserEntity? assignee,
  }) = _TaskEntity;

  factory TaskEntity.fromJson(Map<String, dynamic> json) => _$TaskEntityFromJson(json);
}
