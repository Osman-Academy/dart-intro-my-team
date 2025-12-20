import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/task.dart';
import '../injection.dart';
import 'task_bloc.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(getIt())..add(LoadTasks()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Tasks'),
          centerTitle: true,
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TaskLoaded) {
              if (state.tasks.isEmpty) {
                return const Center(child: Text('List is empty. Add a new task!'));
              }
              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, i) {
                  final task = state.tasks[i];
                  return ListTile(
                    leading: const Icon(Icons.check_circle_outline, color: Colors.blue),
                    title: Text(task.title),
                    subtitle: Text(task.description ?? ''),
                  );
                },
              );
            }
            return const Center(child: Text('Error'));
          },
        ),
        floatingActionButton: Builder(
          builder: (buttonContext) {
            return FloatingActionButton(
              onPressed: () => _showAddTaskDialog(buttonContext),
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  // Функция для вызова окна ввода
  void _showAddTaskDialog(BuildContext blocContext) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: blocContext,
      builder: (context) => AlertDialog(
        title: const Text('New Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'title'),
              autofocus: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(hintText: 'description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newTask = Task(
                  id: DateTime.now().millisecondsSinceEpoch % 1000000,
                  title: titleController.text,
                  description: descController.text,
                  status: "open",
                );
                blocContext.read<TaskBloc>().add(AddTask(newTask));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}