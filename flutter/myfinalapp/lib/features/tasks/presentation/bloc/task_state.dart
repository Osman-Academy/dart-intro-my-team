import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/task.dart';

part 'task_state.freezed.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState({
    required List<Task> allTasks,
    required List<Task> filteredTasks,
    required bool isLoading,
  }) = _TaskState;

  factory TaskState.initial() =>
      const TaskState(allTasks: [], filteredTasks: [], isLoading: false);
}