import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../blocs/task_bloc/task_state.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/auth_bloc/auth_event.dart';
import '../blocs/auth_bloc/auth_state.dart';
import '../widgets/kanban_board/kanban_board.dart';
import '../widgets/task_form/task_form_dialog.dart';
import '../../domain/entities/task_status.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, next) => prev.user?.id != next.user?.id && next.user != null,
      listener: (context, state) {
        context.read<TaskBloc>().add(const LoadTasksEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Team Flow'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<TaskBloc>().add(const RefreshTasksEvent()),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state.user == null) return const SizedBox.shrink();
                return Row(
                  children: [
                    Text(
                      state.user!.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      tooltip: 'Выйти',
                      icon: const Icon(Icons.logout),
                      onPressed: () => context.read<AuthBloc>().add(AuthLogoutRequested()),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Канбан-доска',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1C1F2E),
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Управляйте задачами и статусами в один клик',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade700,
                              ),
                        ),
                      ],
                    ),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF4C5DF4),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final result = await showDialog<TaskFormResult>(
                          context: context,
                          builder: (_) => const TaskFormDialog(),
                        );
                        if (result != null) {
                          // ignore: use_build_context_synchronously
                          context.read<TaskBloc>().add(CreateTaskEvent(
                                title: result.title,
                                description: result.description,
                                projectId: result.projectId,
                              ));
                        }
                      },
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text('Новая задача'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoading || state is TaskInitial) {
                      return const Expanded(child: Center(child: CircularProgressIndicator()));
                    } else if (state is TaskLoaded) {
                      final totals = _countByStatus(state.tasks);
                      return Expanded(
                        child: Column(
                          children: [
                            _StatusChips(totals: totals),
                            const SizedBox(height: 12),
                            Expanded(
                              child: KanbanBoard(
                                tasks: state.tasks,
                                onMove: (id, status) =>
                                    context.read<TaskBloc>().add(MoveTaskEvent(taskId: id, status: status.name)),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is TaskError) {
                      return Expanded(child: Center(child: Text(state.message)));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<TaskStatus, int> _countByStatus(List tasks) {
    final map = {for (var s in TaskStatus.values) s: 0};
    for (final t in tasks) {
      map[t.status] = (map[t.status] ?? 0) + 1;
    }
    return map;
  }
}

class _StatusChips extends StatelessWidget {
  final Map<TaskStatus, int> totals;
  const _StatusChips({required this.totals});

  @override
  Widget build(BuildContext context) {
    Color color(TaskStatus status) {
      return switch (status) {
        TaskStatus.todo => const Color(0xFF6C7BFF),
        TaskStatus.inProgress => const Color(0xFFF6A609),
        TaskStatus.done => const Color(0xFF32C48D),
      };
    }

    String label(TaskStatus status) {
      return switch (status) {
        TaskStatus.todo => 'Todo',
        TaskStatus.inProgress => 'In Progress',
        TaskStatus.done => 'Done',
      };
    }

    return Row(
      children: TaskStatus.values
          .map(
            (s) => Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: color(s).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(color: color(s), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${label(s)} · ${totals[s] ?? 0}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: color(s).withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
