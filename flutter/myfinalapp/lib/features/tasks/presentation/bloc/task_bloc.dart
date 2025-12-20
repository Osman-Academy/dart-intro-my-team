import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_tasks_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasks;

  TaskBloc(this.getTasks) : super(TaskState.initial()) {
    on<TaskEvent>((event, emit) async {
      await event.when(
        load: () async {
          emit(state.copyWith(isLoading: true));

          final tasks = await getTasks();

          emit(
            state.copyWith(
              allTasks: tasks,
              filteredTasks: tasks,
              isLoading: false,
            ),
          );
        },
        search: (query) async {
          final filtered = state.allTasks
              .where(
                (task) =>
                    task.title.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

          emit(state.copyWith(filteredTasks: filtered));
        },
      );
    });
  }
}
