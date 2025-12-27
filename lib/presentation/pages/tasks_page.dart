import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../../injection/injection.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import 'search_bar.dart';

/// Simple UI screen that displays tasks using the `TaskBloc`.
class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(repository: getIt<TaskRepository>())..add(const LoadTasks()),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Tasks'),
            actions: [
              IconButton(
                tooltip: 'Refresh',
                icon: const Icon(Icons.refresh),
                onPressed: () => context.read<TaskBloc>().add(const LoadTasks()),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                const TaskSearchBar(),
                Expanded(child: _TasksView()),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text('Add task'),
            onPressed: () => _showAddBottomSheet(context),
          ),
        ),
      ),
    );
  }

  void _showAddBottomSheet(BuildContext context) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16 + bottomInset),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'New task',
                  style: Theme.of(ctx).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: titleCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Title is required';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                    prefixIcon: Icon(Icons.notes),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!(formKey.currentState?.validate() ?? false)) return;
                          context.read<TaskBloc>().add(
                                AddTask(
                                  title: titleCtrl.text.trim(),
                                  description: descCtrl.text.trim(),
                                ),
                              );
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('Add'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TasksView extends StatelessWidget {
  const _TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TaskError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Error: ${state.message}'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => context.read<TaskBloc>().add(const LoadTasks()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is TaskLoaded) {
          final tasks = state.filteredTasks;

          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks'));
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
            itemCount: tasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) => _TaskTile(task: tasks[index]),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;
  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    final isDone = task.completed;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isDone ? const Color(0xFFE8EAFD) : const Color(0xFFF1F3FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
          ),
        ),
        title: Text(
          task.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          task.description.isEmpty ? 'No description' : task.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Checkbox(
          value: isDone,
          onChanged: (_) => context.read<TaskBloc>().add(ToggleTask(task.id)),
        ),
        onTap: () => context.read<TaskBloc>().add(ToggleTask(task.id)),
      ),
    );
  }
}
