import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/task_repository.dart';
import '../../domain/models/task.dart';
import 'task_event.dart';
import 'task_state.dart';

/// BLoC that loads tasks using the provided repository.
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc({required this.repository}) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<SearchTasks>(_onSearchTasks);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await repository.getTasks();
      emit(TaskLoaded(allTasks: tasks, filteredTasks: tasks, query: ''));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final created = await repository.addTask(
        // construct minimal Task; id will be assigned by server or generated
        // locally by the data source
        Task(id: 0, title: event.title, description: event.description, completed: false),
      );

      final current = await repository.getTasks();
      // Prepend created for better visibility; or reload from server
      final updated = [created, ...current];
      emit(TaskLoaded(allTasks: updated, filteredTasks: updated, query: ''));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onSearchTasks(SearchTasks event, Emitter<TaskState> emit) async {
    final stateNow = state;
    if (stateNow is TaskLoaded) {
      final q = event.query.toLowerCase();
      final filtered = stateNow.allTasks.where((t) => t.title.toLowerCase().contains(q) || t.description.toLowerCase().contains(q)).toList();
      emit(TaskLoaded(allTasks: stateNow.allTasks, filteredTasks: filtered, query: event.query));
    } else {
      // If we have no data yet, try to load then filter
      add(const LoadTasks());
    }
  }
}
