import 'package:bloc/bloc.dart';
import 'package:flutter_application_finall_project/domain/entities/task.dart';
import 'package:flutter_application_finall_project/domain/usecases/get_tasks.dart';
import 'package:flutter_application_finall_project/domain/usecases/add_task.dart';
import 'package:flutter_application_finall_project/domain/usecases/update_task.dart';
import 'package:flutter_application_finall_project/domain/usecases/delete_task.dart';
import 'package:flutter_application_finall_project/presentation/bloc/task_event.dart';
import 'package:flutter_application_finall_project/presentation/bloc/task_state.dart';

/// BLoC responsible for orchestrating task-loading and manipulation flows.
/// Handles fetching, adding, updating, deleting, searching, and filtering tasks.
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  /// Keep track of all loaded tasks for operations like delete/update/filter.
  List<Task> _allTasks = [];

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskInitial()) {
    on<FetchTasks>(_onFetchTasks);
    on<RefreshTasks>(_onRefreshTasks);
    on<AddTaskEvent>(_onAddTask);
    on<ToggleTaskCompletion>(_onToggleTaskCompletion);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<SearchTasks>(_onSearchTasks);
    on<ClearSearch>(_onClearSearch);
    on<FilterByStatus>(_onFilterByStatus);
    on<FilterByPriority>(_onFilterByPriority);
    on<FilterByDueDate>(_onFilterByDueDate);
    on<ClearFilters>(_onClearFilters);
    on<UpdateTaskDetailsEvent>(_onUpdateTaskDetails);
  }

  /// Handle FetchTasks event - initial load.
  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await getTasks();
      _allTasks = tasks;
      if (tasks.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(tasks));
      }
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle RefreshTasks event - pull-to-refresh.
  Future<void> _onRefreshTasks(RefreshTasks event, Emitter<TaskState> emit) async {
    emit(TaskRefreshing(_allTasks));
    try {
      final tasks = await getTasks();
      _allTasks = tasks;
      if (tasks.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(tasks));
      }
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle AddTask event - create a new task with priority and due date.
  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskOperationLoading(_allTasks));
    try {
      final newTask = await addTask(AddTaskParams(
        title: event.title,
        description: event.description,
        priority: event.priority,
        dueDate: event.dueDate,
      ));
      _allTasks.insert(0, newTask); // Add to beginning
      emit(TaskAdded(newTask, _allTasks));
      emit(TaskLoaded(_allTasks));
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle ToggleTaskCompletion event - update task completion status.
  Future<void> _onToggleTaskCompletion(
    ToggleTaskCompletion event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskOperationLoading(_allTasks));
    try {
      final updatedTask = await updateTask(UpdateTaskParams(
        id: event.taskId,
        title: null,
        description: null,
        completed: event.completed,
      ));
      final index = _allTasks.indexWhere((t) => t.id == event.taskId);
      if (index != -1) {
        _allTasks[index] = updatedTask;
      }
      emit(TaskUpdated(updatedTask, _allTasks));
      emit(TaskLoaded(_allTasks));
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle DeleteTask event - remove a task.
  Future<void> _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskOperationLoading(_allTasks));
    try {
      await deleteTask(event.taskId);
      _allTasks.removeWhere((t) => t.id == event.taskId);
      emit(TaskDeleted(event.taskId, _allTasks));
      if (_allTasks.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(_allTasks));
      }
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle SearchTasks event - filter tasks by query.
  Future<void> _onSearchTasks(SearchTasks event, Emitter<TaskState> emit) async {
    try {
      final filtered = _allTasks
          .where((task) =>
              task.title.toLowerCase().contains(event.query.toLowerCase()) ||
              task.description.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      if (filtered.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(filtered, searchQuery: event.query));
      }
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle ClearSearch event - show all tasks again.
  Future<void> _onClearSearch(ClearSearch event, Emitter<TaskState> emit) async {
    try {
      if (_allTasks.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(_allTasks));
      }
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle FilterByStatus event - filter tasks by completion status.
  Future<void> _onFilterByStatus(FilterByStatus event, Emitter<TaskState> emit) async {
    try {
      final filtered = _allTasks.where((task) => task.completed == event.isCompleted).toList();
      if (filtered.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(filtered));
      }
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle FilterByPriority event - filter tasks by priority level.
  Future<void> _onFilterByPriority(FilterByPriority event, Emitter<TaskState> emit) async {
    try {
      final filtered = _allTasks.where((task) => task.priority == event.priority).toList();
      if (filtered.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(filtered));
      }
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle FilterByDueDate event - filter tasks by due date range.
  Future<void> _onFilterByDueDate(FilterByDueDate event, Emitter<TaskState> emit) async {
    try {
      final filtered = _allTasks.where((task) {
        if (task.dueDate == null) return false;
        return task.dueDate!.isAfter(event.startDate) && task.dueDate!.isBefore(event.endDate);
      }).toList();
      if (filtered.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(filtered));
      }
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle ClearFilters event - show all tasks without any filtering.
  Future<void> _onClearFilters(ClearFilters event, Emitter<TaskState> emit) async {
    try {
      if (_allTasks.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(_allTasks));
      }
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Handle UpdateTaskDetailsEvent - update task details (priority, due date, etc).
  Future<void> _onUpdateTaskDetails(
    UpdateTaskDetailsEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskOperationLoading(_allTasks));
    try {
      final updatedTask = await updateTask(UpdateTaskParams(
        id: event.taskId,
        title: event.title,
        description: event.description,
        priority: event.priority,
        dueDate: event.dueDate,
      ));
      final index = _allTasks.indexWhere((t) => t.id == event.taskId);
      if (index != -1) {
        _allTasks[index] = updatedTask;
      }
      emit(TaskUpdated(updatedTask, _allTasks));
      emit(TaskLoaded(_allTasks));
    } catch (e) {
      emit(TaskError(_parseError(e)));
    }
  }

  /// Parse error to user-friendly message.
  String _parseError(Object error) {
    if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    }
    return error.toString();
  }
}
