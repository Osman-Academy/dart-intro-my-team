import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/task.dart';
import '../../injection/injection.dart';
import '../../presentation/bloc/task_bloc.dart';
import '../../domain/models/task.dart';
import '../../presentation/bloc/task_event.dart';
import '../../presentation/bloc/task_state.dart';
import '../../domain/repositories/task_repository.dart';
import 'search_bar.dart';

/// Simple UI screen that displays tasks using the `TaskBloc`.
class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provide a TaskBloc using the repository from the DI container.
    return BlocProvider(
      create: (_) => TaskBloc(repository: getIt<TaskRepository>())..add(const LoadTasks()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Tasks')),
        body: Column(
          children: const [
            const TaskSearchBar(),
            Expanded(child: _TasksView()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _showAddDialog(context),
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
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final title = titleCtrl.text.trim();
              final desc = descCtrl.text.trim();
              if (title.isEmpty) {
                // simple validation
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title is required')));
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
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
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
    });
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;

  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: task.completed,
      onChanged: (_) {},
      title: Text(task.title),
      subtitle: Text(task.description.isEmpty ? 'No description' : task.description),
    );
  }
}
