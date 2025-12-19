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
  title: const Text('My Tasks'),
  backgroundColor: Colors.indigo,
),
backgroundColor: const Color(0xFFF1F3FA),

          body: Column(
            children: [
              const TaskSearchBar(),
              Expanded(child: _TasksView()),
            ],
          ),
          floatingActionButton: FloatingActionButton(
  backgroundColor: Colors.indigo,
  child: const Icon(Icons.add, color: Colors.white),
  onPressed: () => _showAddDialog(context),
),

        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final title = titleCtrl.text.trim();
              final desc = descCtrl.text.trim();

              if (title.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Title is required')),
                );
                return;
              }

              context.read<TaskBloc>().add(AddTask(title: title, description: desc));
              Navigator.of(ctx).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
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

          return ListView.builder(
            itemCount: tasks.length,
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
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDone ? Colors.indigo.shade50 : Colors.white,
      child: CheckboxListTile(
        value: isDone,
        onChanged: (_) {
          context.read<TaskBloc>().add(ToggleTask(task.id));
        },
        activeColor: Colors.indigo,
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration: isDone ? TextDecoration.lineThrough : null,
            color: isDone ? Colors.indigo : Colors.black87,
          ),
        ),
        subtitle: Text(
          task.description.isEmpty ? 'No description' : task.description,
          style: TextStyle(
            color: isDone ? Colors.indigo.shade300 : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
