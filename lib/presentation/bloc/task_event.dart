import 'package:equatable/equatable.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';

/// Events for TaskBloc to handle various task operations.
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

/// Fetch all tasks from the server.
class FetchTasks extends TaskEvent {
  const FetchTasks();
}

/// Refresh tasks by fetching from server (pull-to-refresh).
class RefreshTasks extends TaskEvent {
  const RefreshTasks();
}

/// Add a new task to the server.
class AddTaskEvent extends TaskEvent {
  final String title;
  final String description;
  final TaskPriority priority;
  final DateTime? dueDate;

  const AddTaskEvent({
    required this.title,
    required this.description,
    this.priority = TaskPriority.medium,
    this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, priority, dueDate];
}

/// Toggle the completion status of a task.
class ToggleTaskCompletion extends TaskEvent {
  final int taskId;
  final bool completed;

  const ToggleTaskCompletion({
    required this.taskId,
    required this.completed,
  });

  @override
  List<Object?> get props => [taskId, completed];
}

/// Delete a task by its ID.
class DeleteTaskEvent extends TaskEvent {
  final int taskId;

  const DeleteTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

/// Update task details (title, description, priority, due date).
class UpdateTaskDetailsEvent extends TaskEvent {
  final int taskId;
  final String? title;
  final String? description;
  final TaskPriority? priority;
  final DateTime? dueDate;

  const UpdateTaskDetailsEvent({
    required this.taskId,
    this.title,
    this.description,
    this.priority,
    this.dueDate,
  });

  @override
  List<Object?> get props => [taskId, title, description, priority, dueDate];
}

/// Search or filter tasks by title.
class SearchTasks extends TaskEvent {
  final String query;

  const SearchTasks(this.query);

  @override
  List<Object?> get props => [query];
}

/// Clear search filter and show all tasks.
class ClearSearch extends TaskEvent {
  const ClearSearch();
}

/// Filter tasks by completion status.
class FilterByStatus extends TaskEvent {
  final bool isCompleted;

  const FilterByStatus(this.isCompleted);

  @override
  List<Object?> get props => [isCompleted];
}

/// Filter tasks by priority level.
class FilterByPriority extends TaskEvent {
  final TaskPriority priority;

  const FilterByPriority(this.priority);

  @override
  List<Object?> get props => [priority];
}

/// Filter tasks by due date range.
class FilterByDueDate extends TaskEvent {
  final DateTime startDate;
  final DateTime endDate;

  const FilterByDueDate(this.startDate, this.endDate);

  @override
  List<Object?> get props => [startDate, endDate];
}

/// Clear all active filters.
class ClearFilters extends TaskEvent {
  const ClearFilters();
}
