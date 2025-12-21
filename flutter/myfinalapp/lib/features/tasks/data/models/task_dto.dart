import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/task.dart';

part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

@freezed
class TaskDto with _$TaskDto {
  const TaskDto._();

  const factory TaskDto({
    required int id,
    required String title,
    required bool completed,
  }) = _TaskDto;

  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);

  /// DTO → Domain
  Task toDomain() {
    return Task(id: id, title: title, completed: completed);
  }

  /// Domain → DTO
  factory TaskDto.fromDomain(Task task) {
    return TaskDto(id: task.id, title: task.title, completed: task.completed);
  }
}
