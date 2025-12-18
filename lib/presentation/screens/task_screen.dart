
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection.dart';
import '../../domain/entities/task.dart';
import '../../presentation/bloc/task_bloc.dart';
import '../../presentation/bloc/task_event.dart';
import '../../presentation/bloc/task_state.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TaskBloc _taskBloc;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;
  String _lastSearchQuery = '';

  @override
  void initState() {
    super.initState();
    _taskBloc = getIt<TaskBloc>();
    _taskBloc.add(LoadTasks());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
      if (!_isSearchActive) {
        _searchController.clear();
        _lastSearchQuery = '';
        _taskBloc.add(LoadTasks());
      }
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _lastSearchQuery = value;
    });
    
    if (value.trim().isNotEmpty) {
      _taskBloc.add(SearchTasks(query: value.trim()));
    } else if (value.isEmpty && _lastSearchQuery.isNotEmpty) {
      _taskBloc.add(LoadTasks());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearchActive
            ? Container(
                height: 40,

                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search tasks...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: Colors.white70, size: 20),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    isDense: true,
                  ),
                  onChanged: _onSearchChanged,
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      _taskBloc.add(SearchTasks(query: value.trim()));
                    }
                  },
                ),
              )
            : const Text('Task Manager'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          if (_isSearchActive && _lastSearchQuery.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: Center(
                child: Text(
                  'Found results',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          IconButton(
            icon: Icon(_isSearchActive ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
            tooltip: _isSearchActive ? 'Close search' : 'Search tasks',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _taskBloc.add(RefreshTasks()),
            tooltip: 'Refresh tasks',
          ),
        ],
      ),

      body: BlocBuilder<TaskBloc, TaskState>(
        bloc: _taskBloc,
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    _isSearchActive ? 'Searching tasks...' : 'Loading tasks...',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is TaskError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _taskBloc.add(LoadTasks()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is TaskEmpty) {
            return _isSearchActive 
                ? _buildSearchEmptyState(_lastSearchQuery)
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_alt,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No tasks found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tap the + button to add a new task',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
          } else if (state is TaskLoaded) {
            return _buildTaskList(state.tasks, isSearchResult: _isSearchActive);
          } else if (state is TaskSearchLoaded) {
            return _buildTaskList(state.tasks, isSearchResult: true, query: state.query);
          } else if (state is TaskSearchEmpty) {
            return _buildSearchEmptyState(state.query);
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildTaskList(List<Task> tasks, {bool isSearchResult = false, String? query}) {
    return Column(
      children: [
        if (isSearchResult && query != null && query.isNotEmpty)
          Container(
            width: double.infinity,
            color: Colors.blue.shade50,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              'Search results for "$query" (${tasks.length} found)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              if (isSearchResult && _lastSearchQuery.isNotEmpty) {
                _taskBloc.add(SearchTasks(query: _lastSearchQuery));
              } else {
                _taskBloc.add(RefreshTasks());
              }
              return Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return _buildTaskItem(task);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchEmptyState(String query) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 24),
          Text(
            'No tasks found for',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '"$query"',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Try searching for:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _buildSearchSuggestion('Flutter'),
              _buildSearchSuggestion('Review'),
              _buildSearchSuggestion('Tests'),
              _buildSearchSuggestion('Project'),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _toggleSearch,
            icon: const Icon(Icons.close),
            label: const Text('Close Search'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSuggestion(String text) {
    return GestureDetector(
      onTap: () {
        _searchController.text = text;
        _searchController.selection = TextSelection.collapsed(offset: text.length);
        _onSearchChanged(text);
      },
      child: Chip(
        label: Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
        backgroundColor: Colors.blue.shade100,
        labelStyle: TextStyle(color: Colors.blue.shade700),
        onDeleted: null,
      ),
    );
  }

  Widget _buildTaskItem(Task task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            _taskBloc.add(ToggleTaskEvent(taskId: task.id));
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: task.isCompleted ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description,
              style: TextStyle(
                color: task.isCompleted ? Colors.grey : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Created: ${task.createdAt != null ? _formatDate(task.createdAt!) : "Unknown"}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteConfirmation(task),
        ),
        onTap: () {
          _taskBloc.add(ToggleTaskEvent(taskId: task.id));
        },
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => _AddTaskDialog(
        onAddTask: (title, description) {
          _taskBloc.add(AddTaskEvent(
            title: title,
            description: description,
          ));
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showDeleteConfirmation(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _taskBloc.add(DeleteTaskEvent(taskId: task.id));
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _AddTaskDialog extends StatefulWidget {
  final Function(String title, String description) onAddTask;

  const _AddTaskDialog({required this.onAddTask});

  @override
  State<_AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<_AddTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.trim().isNotEmpty) {
              widget.onAddTask(
                _titleController.text.trim(),
                _descriptionController.text.trim(),
              );
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
