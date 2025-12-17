import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_finall_project/domain/entities/task.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';

/// Task details page that shows full task information and allows editing.
/// Provides options to edit title, description, priority, and due date.
class TaskDetailsPage extends StatefulWidget {
  final Task task;
  final VoidCallback? onTaskUpdated;
  final VoidCallback? onTaskDeleted;

  const TaskDetailsPage({
    super.key,
    required this.task,
    this.onTaskUpdated,
    this.onTaskDeleted,
  });

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TaskPriority _priority;
  late DateTime? _dueDate;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _priority = widget.task.priority;
    _dueDate = widget.task.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveChanges();
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge
            Chip(
              label: Text(
                widget.task.completed ? 'Completed' : 'Pending',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: widget.task.completed ? Colors.green : Colors.orange,
            ),
            const SizedBox(height: 16),

            // Title
            if (_isEditing)
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              )
            else
              Text(
                widget.task.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      decoration: widget.task.completed ? TextDecoration.lineThrough : null,
                    ),
              ),
            const SizedBox(height: 24),

            // Priority section
            _buildSectionTitle('Priority'),
            _buildPriorityDisplay(),
            const SizedBox(height: 24),

            // Due date section
            _buildSectionTitle('Due Date'),
            _buildDueDateDisplay(),
            const SizedBox(height: 24),

            // Description
            _buildSectionTitle('Description'),
            if (_isEditing)
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.task.description.isEmpty ? 'No description' : widget.task.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: widget.task.description.isEmpty ? Colors.grey : Colors.black,
                        decoration: widget.task.completed ? TextDecoration.lineThrough : null,
                      ),
                ),
              ),
            const SizedBox(height: 32),

            // Delete button
            if (!_isEditing)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: _showDeleteConfirmation,
                  child: const Text(
                    'Delete Task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildPriorityDisplay() {
    final color = _priorityColor(_priority);
    return _isEditing
        ? GestureDetector(
            onTap: () => _showPriorityPicker(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_priority.displayName),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _priority.displayName,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          );
  }

  Widget _buildDueDateDisplay() {
    return _isEditing
        ? GestureDetector(
            onTap: () => _showDatePicker(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _dueDate == null
                        ? 'No due date'
                        : DateFormat('MMM dd, yyyy').format(_dueDate!),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _dueDate != null && widget.task.isOverdue
                  ? Colors.red.shade100
                  : Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _dueDate != null && widget.task.isOverdue ? Colors.red : Colors.blue,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _dueDate != null && widget.task.isOverdue ? Icons.warning : Icons.calendar_today,
                  color: _dueDate != null && widget.task.isOverdue ? Colors.red : Colors.blue,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  _dueDate == null
                      ? 'No due date'
                      : DateFormat('MMM dd, yyyy').format(_dueDate!),
                  style: TextStyle(
                    color: _dueDate != null && widget.task.isOverdue ? Colors.red : Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
  }

  Color _priorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }

  void _showPriorityPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Priority',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...TaskPriority.values.map((priority) {
                return ListTile(
                  leading: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: _priorityColor(priority),
                      shape: BoxShape.circle,
                    ),
                  ),
                  title: Text(priority.displayName),
                  trailing: _priority == priority ? const Icon(Icons.check) : null,
                  onTap: () {
                    setState(() => _priority = priority);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  void _saveChanges() {
    // In a real implementation, this would trigger a BLoC event to update the task
    setState(() => _isEditing = false);
    widget.onTaskUpdated?.call();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task updated')),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to task list
              widget.onTaskDeleted?.call();
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
