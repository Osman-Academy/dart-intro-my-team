import 'package:bloc/bloc.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/entities/task_status.dart';
import 'task_event.dart';
import 'task_state.dart';

/// Simple in-memory Bloc for scaffolding. Replace with injected use cases.
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskInitial()) {
    on<LoadTasksEvent>(_onLoad);
    on<RefreshTasksEvent>(_onLoad);
    on<MoveTaskEvent>(_onMove);
    on<CreateTaskEvent>(_onCreate);
  }

  final List<TaskEntity> _tasks = [
    TaskEntity(
      id: '1',
      title: 'Set up architecture',
      description: 'Create Clean Architecture skeleton',
      status: TaskStatus.todo,
      projectId: 'teamflow',
    ),
    TaskEntity(
      id: '2',
      title: 'Design UI',
      description: 'Draft Kanban board widgets',
      status: TaskStatus.inProgress,
      projectId: 'teamflow',
    ),
  ];

  void _onLoad(TaskEvent event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    await Future<void>.delayed(const Duration(milliseconds: 300));
    emit(TaskLoaded(List.of(_tasks)));
  }

  void _onMove(MoveTaskEvent event, Emitter<TaskState> emit) {
    final idx = _tasks.indexWhere((t) => t.id == event.taskId);
    if (idx == -1) return;
    final status = TaskStatus.values.firstWhere(
      (s) => s.name.toUpperCase() == event.status.toUpperCase(),
      orElse: () => TaskStatus.todo,
    );
    _tasks[idx] = _tasks[idx].copyWith(status: status);
    emit(TaskLoaded(List.of(_tasks)));
  }

  void _onCreate(CreateTaskEvent event, Emitter<TaskState> emit) {
    final newTask = TaskEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: event.title,
      description: event.description,
      status: TaskStatus.todo,
      projectId: event.projectId,
    );
    _tasks.add(newTask);
    emit(TaskLoaded(List.of(_tasks)));
  }
}
