import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/task.dart';

part 'task_state.freezed.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState({
    @Default(false) bool isLoading,
    @Default([]) List<Task> allTasks,
    @Default([]) List<Task> filteredTasks,
    @Default('') String searchQuery,
  }) = _TaskState;
}
