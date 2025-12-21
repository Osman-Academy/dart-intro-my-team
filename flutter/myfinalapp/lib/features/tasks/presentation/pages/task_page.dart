import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../widgets/add_task_dialog.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TaskBloc>()..add(const TaskEvent.load()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Task Manager')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddDialog(context),
          child: const Icon(Icons.add),
        ),
        body: const _TaskBody(),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => const AddTaskDialog());
  }
}

class _TaskBody extends StatelessWidget {
  const _TaskBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // 🔍 SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search tasks',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  context.read<TaskBloc>().add(TaskEvent.search(value));
                },
              ),
            ),

            // 📋 TASK LIST
            Expanded(
              child: state.filteredTasks.isEmpty
                  ? const Center(child: Text('No tasks found'))
                  : ListView.builder(
                      itemCount: state.filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = state.filteredTasks[index];
                        return _TaskTile(task: task);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;

  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      leading: Checkbox(
        value: task.completed,
        onChanged: (_) {
          context.read<TaskBloc>().add(
            TaskEvent.update(task.copyWith(completed: !task.completed)),
          );
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          context.read<TaskBloc>().add(TaskEvent.delete(task.id));
        },
      ),
    );
  }
}
