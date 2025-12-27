import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/task.dart';
import '../../domain/repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

/// BLoC that loads tasks using the provided repository.
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc({required this.repository}) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<SearchTasks>(_onSearchTasks);
    on<ToggleTask>(_onToggleTask);
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
    final stateNow = state;

    // Если ещё не загрузились — сначала загрузим
    if (stateNow is! TaskLoaded) {
      add(const LoadTasks());
      return;
    }

    try {
      final created = await repository.addTask(
        Task(
          id: 0,
          title: event.title,
          description: event.description,
          completed: false,
        ),
      );

      // JSONPlaceholder "не сохраняет", поэтому добавляем локально в список
      final updated = [created, ...stateNow.allTasks];

      emit(TaskLoaded(
        allTasks: updated,
        filteredTasks: _applyFilter(updated, stateNow.query),
        query: stateNow.query,
      ));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onSearchTasks(SearchTasks event, Emitter<TaskState> emit) async {
    final stateNow = state;

    if (stateNow is! TaskLoaded) {
      add(const LoadTasks());
      return;
    }

    final pattern = event.query.trim();

    // пустой запрос = показать всё
    if (pattern.isEmpty) {
      emit(TaskLoaded(
        allTasks: stateNow.allTasks,
        filteredTasks: stateNow.allTasks,
        query: '',
      ));
      return;
    }

    // Pattern search (RegExp)
    try {
      final reg = RegExp(pattern, caseSensitive: false);

      final filtered = stateNow.allTasks.where((t) {
        return reg.hasMatch(t.title) || reg.hasMatch(t.description);
      }).toList();

      emit(TaskLoaded(
        allTasks: stateNow.allTasks,
        filteredTasks: filtered,
        query: pattern,
      ));
    } catch (_) {
      emit(const TaskError('Invalid pattern. Example: "api|server" or "^de".'));
    }
  }

  void _onToggleTask(ToggleTask event, Emitter<TaskState> emit) {
    final stateNow = state;
    if (stateNow is! TaskLoaded) return;

    final updated = stateNow.allTasks.map((t) {
      if (t.id == event.id) {
        return t.copyWith(completed: !t.completed);
      }
      return t;
    }).toList();

    emit(TaskLoaded(
      allTasks: updated,
      filteredTasks: _applyFilter(updated, stateNow.query),
      query: stateNow.query,
    ));
  }

  List<Task> _applyFilter(List<Task> all, String query) {
    final q = query.trim();
    if (q.isEmpty) return all;

    try {
      final reg = RegExp(q, caseSensitive: false);
      return all.where((t) => reg.hasMatch(t.title) || reg.hasMatch(t.description)).toList();
    } catch (_) {
      // если query невалидный regex — просто возвращаем все
      return all;
    }
  }
}
