import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_finall_project/presentation/bloc/task_bloc.dart';
import 'package:flutter_application_finall_project/presentation/bloc/task_event.dart';
import 'package:flutter_application_finall_project/presentation/bloc/task_state.dart';
import 'package:flutter_application_finall_project/presentation/widgets/task_item.dart';
import 'package:flutter_application_finall_project/presentation/widgets/add_task_dialog.dart';
import 'package:flutter_application_finall_project/presentation/widgets/task_search_bar.dart';
import 'package:flutter_application_finall_project/presentation/pages/task_details_page.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';

/// Page that displays the list of tasks fetched from the server.
/// Features: ListView with checkboxes, delete buttons, search, pull-to-refresh, FAB for adding tasks.
class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  bool _showSearchBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(_showSearchBar ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
                if (!_showSearchBar) {
                  context.read<TaskBloc>().add(const ClearSearch());
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar (shown conditionally)
          if (_showSearchBar)
            TaskSearchBar(
              onSearch: (query) {
                context.read<TaskBloc>().add(SearchTasks(query));
              },
              onClear: () {
                context.read<TaskBloc>().add(const ClearSearch());
              },
            ),
          // Tasks list with pull-to-refresh
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskInitial || state is TaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TaskRefreshing) {
                  // Show previous tasks while refreshing
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<TaskBloc>().add(const RefreshTasks());
                    },
                    child: _buildTaskListView(state.previousTasks),
                  );
                } else if (state is TaskLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<TaskBloc>().add(const RefreshTasks());
                    },
                    child: _buildTaskListView(state.tasks),
                  );
                } else if (state is TaskEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<TaskBloc>().add(const RefreshTasks());
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 64,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No tasks yet',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap the + button to add your first task',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is TaskError) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<TaskBloc>().add(const RefreshTasks());
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 64,
                                    color: Colors.red.shade300,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Error loading tasks',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    state.message,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => context.read<TaskBloc>().add(const FetchTasks()),
                                    child: const Text('Retry'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is TaskOperationLoading) {
                  // Show previous tasks while operation is in progress
                  return Stack(
                    children: [
                      _buildTaskListView(state.currentTasks),
                      Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      // FloatingActionButton to add new tasks
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Build the ListView of tasks.
  Widget _buildTaskListView(List<dynamic> tasks) {
    if (tasks.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tasks found',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: tasks.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskItem(
          task: task,
          onToggleCompletion: () {
            context.read<TaskBloc>().add(
                  ToggleTaskCompletion(
                    taskId: task.id,
                    completed: !task.completed,
                  ),
                );
          },
          onDelete: () {
            _showDeleteConfirmation(context, task.id, task.title);
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailsPage(task: task),
              ),
            );
          },
        );
      },
    );
  }

  /// Show bottom sheet to add a new task.
  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add New Task', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showAddTaskDialog(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Create Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Show dialog to add a new task.
  Future<void> _showAddTaskDialog(BuildContext context) async {
    final result = await showAddTaskDialog(context);
    if (result != null && mounted) {
      // ignore: use_build_context_synchronously
      context.read<TaskBloc>().add(
            AddTaskEvent(
              title: result['title']!,
              description: result['description'] ?? '',
              priority: result['priority'] as TaskPriority? ?? TaskPriority.medium,
              dueDate: result['dueDate'] as DateTime?,
            ),
          );
      // Show success snackbar
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task added successfully')),
      );
    }
  }

  /// Show delete confirmation dialog.
  void _showDeleteConfirmation(BuildContext context, int taskId, String taskTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "$taskTitle"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              Navigator.pop(context);
              context.read<TaskBloc>().add(DeleteTaskEvent(taskId));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
