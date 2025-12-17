import 'package:flutter/material.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';
import 'package:intl/intl.dart';

/// Dialog for adding a new task with enhanced fields.
/// Returns a map with 'title', 'description', 'priority', and 'dueDate' keys if user submits.
Future<Map<String, dynamic>?> showAddTaskDialog(BuildContext context) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<_AddTaskDialogState>();

  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) => _AddTaskDialog(
      key: formKey,
      titleController: titleController,
      descriptionController: descriptionController,
    ),
  );
}

class _AddTaskDialog extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const _AddTaskDialog({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  State<_AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<_AddTaskDialog> {
  TaskPriority _selectedPriority = TaskPriority.medium;
  DateTime? _selectedDueDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title field
            TextField(
              controller: widget.titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter task title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Description field
            TextField(
              controller: widget.descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Enter task description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Priority section
            const Text(
              'Priority',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: TaskPriority.values.map((priority) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedPriority = priority),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedPriority == priority
                          ? _getPriorityColor(priority)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      priority.displayName,
                      style: TextStyle(
                        color: _selectedPriority == priority ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Due date section
            const Text(
              'Due Date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _selectDueDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDueDate == null
                          ? 'Select a due date'
                          : DateFormat('MMM dd, yyyy').format(_selectedDueDate!),
                      style: TextStyle(
                        color: _selectedDueDate == null ? Colors.grey : Colors.black,
                      ),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                  ],
                ),
              ),
            ),
            if (_selectedDueDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton.icon(
                  onPressed: () => setState(() => _selectedDueDate = null),
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Clear'),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.titleController.text.isNotEmpty) {
              Navigator.pop(context, {
                'title': widget.titleController.text,
                'description': widget.descriptionController.text,
                'priority': _selectedPriority,
                'dueDate': _selectedDueDate,
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a task title')),
              );
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  Future<void> _selectDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => _selectedDueDate = picked);
    }
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }
}
