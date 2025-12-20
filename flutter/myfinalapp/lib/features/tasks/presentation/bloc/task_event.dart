import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_event.freezed.dart';

@freezed
class TaskEvent with _$TaskEvent {
  const factory TaskEvent.loadTasks() = LoadTasks;

  const factory TaskEvent.search({
    required String query,
  }) = _SearchTasks;
}