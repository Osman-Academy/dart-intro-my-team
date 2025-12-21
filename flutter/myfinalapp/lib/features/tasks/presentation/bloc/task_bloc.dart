import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<TaskEvent>((event, emit) async {
      await event.map(
        load: (_) async {
          emit(
            state.copyWith(isLoading: false, allTasks: [], filteredTasks: []),
          );
        },
        add: (e) async {
          final updated = List<Task>.from(state.allTasks)..add(e.task);

          emit(
            state.copyWith(
              allTasks: updated,
              filteredTasks: _applySearch(updated, state.searchQuery),
            ),
          );
        },
        update: (e) async {
          final updated = state.allTasks
              .map((t) => t.id == e.task.id ? e.task : t)
              .toList();

          emit(
            state.copyWith(
              allTasks: updated,
              filteredTasks: _applySearch(updated, state.searchQuery),
            ),
          );
        },
        delete: (e) async {
          final updated = state.allTasks.where((t) => t.id != e.id).toList();

          emit(
            state.copyWith(
              allTasks: updated,
              filteredTasks: _applySearch(updated, state.searchQuery),
            ),
          );
        },
        search: (e) async {
          emit(
            state.copyWith(
              searchQuery: e.query,
              filteredTasks: _applySearch(state.allTasks, e.query),
            ),
          );
        },
      );
    });
  }

  List<Task> _applySearch(List<Task> tasks, String query) {
    if (query.isEmpty) return tasks;

    final lower = query.toLowerCase();
    return tasks.where((t) => t.title.toLowerCase().contains(lower)).toList();
  }
}
