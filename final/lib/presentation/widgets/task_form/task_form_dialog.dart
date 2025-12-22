import 'package:flutter/material.dart';

class TaskFormResult {
  final String title;
  final String description;
  final String projectId;
  TaskFormResult({
    required this.title,
    required this.description,
    required this.projectId,
  });
}

class TaskFormDialog extends StatefulWidget {
  const TaskFormDialog({super.key});

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _projectIdController = TextEditingController(text: 'teamflow');

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _projectIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (v) => (v == null || v.isEmpty) ? 'Enter title' : null,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              minLines: 2,
              maxLines: 3,
            ),
            TextFormField(
              controller: _projectIdController,
              decoration: const InputDecoration(labelText: 'Project ID'),
              validator: (v) => (v == null || v.isEmpty) ? 'Enter project ID' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.of(context).pop(TaskFormResult(
                title: _titleController.text,
                description: _descriptionController.text,
                projectId: _projectIdController.text,
              ));
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
