import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _repository;


  TaskBloc(this._repository) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<ToggleTaskEvent>(_onToggleTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<RefreshTasks>(_onRefreshTasks);
    on<SearchTasks>(_onSearchTasks);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await _repository.getTasks();
      if (tasks.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(tasks: tasks));
      }
    } catch (e) {
      emit(TaskError(message: 'Failed to load tasks: ${e.toString()}'));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: event.title,
        description: event.description,
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      await _repository.addTask(newTask);
      final tasks = await _repository.getTasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: 'Failed to add task: ${e.toString()}'));
    }
  }

  Future<void> _onToggleTask(ToggleTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await _repository.toggleTaskCompletion(event.taskId);
      final tasks = await _repository.getTasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: 'Failed to toggle task: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await _repository.deleteTask(event.taskId);
      final tasks = await _repository.getTasks();
      if (tasks.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(tasks: tasks));
      }
    } catch (e) {
      emit(TaskError(message: 'Failed to delete task: ${e.toString()}'));
    }
  }


  Future<void> _onRefreshTasks(RefreshTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await _repository.refreshTasks();
      if (tasks.isEmpty) {
        emit(TaskEmpty());
      } else {
        emit(TaskLoaded(tasks: tasks));
      }
    } catch (e) {
      emit(TaskError(message: 'Failed to refresh tasks: ${e.toString()}'));
    }
  }


  Future<void> _onSearchTasks(SearchTasks event, Emitter<TaskState> emit) async {
    try {
      final searchResults = await _repository.searchTasks(event.query);
      
      if (event.query.trim().isEmpty) {
        if (searchResults.isEmpty) {
          emit(TaskEmpty());
        } else {
          emit(TaskLoaded(tasks: searchResults));
        }
        return;
      }

      if (searchResults.isEmpty) {
        emit(TaskSearchEmpty(query: event.query));
      } else {
        emit(TaskSearchLoaded(tasks: searchResults, query: event.query));
      }
    } catch (e) {
      emit(TaskError(message: 'Failed to search tasks: ${e.toString()}'));
    }
  }
}
