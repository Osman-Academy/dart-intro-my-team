import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(const TaskEvent.load());
  }

  void _addDialog() {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        final bottom = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('New task',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextField(
                controller: ctrl,
                autofocus: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Type something…',
                  prefixIcon: Icon(Icons.edit_note_rounded),
                ),
                onSubmitted: (_) => _submitAdd(ctrl),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => _submitAdd(ctrl),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitAdd(TextEditingController ctrl) {
    final title = ctrl.text.trim();
    if (title.isEmpty) return;
    context.read<TaskBloc>().add(TaskEvent.add(title));
    Navigator.pop(context);
  }

  void _editDialog(Task task) {
    final ctrl = TextEditingController(text: task.title);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        final bottom = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Edit task',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextField(
                controller: ctrl,
                autofocus: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Update title…',
                  prefixIcon: Icon(Icons.tune_rounded),
                ),
                onSubmitted: (_) => _submitEdit(task, ctrl),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => _submitEdit(task, ctrl),
                icon: const Icon(Icons.check_rounded),
                label: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitEdit(Task task, TextEditingController ctrl) {
    final title = ctrl.text.trim();
    if (title.isEmpty) return;
    context.read<TaskBloc>().add(TaskEvent.edit(task.copyWith(title: title)));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0,
              title: const Text('Task Manager'),
              actions: [
                IconButton(
                  tooltip: 'Add',
                  onPressed: _addDialog,
                  icon: const Icon(Icons.add_circle_outline_rounded),
                ),
                const SizedBox(width: 4),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(72),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Search by pattern…',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: IconButton(
                        tooltip: 'Clear',
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          _searchCtrl.clear();
                          context
                              .read<TaskBloc>()
                              .add(const TaskEvent.search(''));
                        },
                      ),
                    ),
                    onChanged: (v) =>
                        context.read<TaskBloc>().add(TaskEvent.search(v)),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (msg) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: _ErrorCard(message: msg),
                    ),
                    loaded: (tasks) {
                      final done = tasks.where((t) => t.completed).length;
                      final left = tasks.length - done;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                        child: Row(
                          children: [
                            _Chip(
                                text: '${tasks.length} total',
                                icon: Icons.list_alt_rounded),
                            const SizedBox(width: 8),
                            _Chip(
                                text: '$left active',
                                icon: Icons.radio_button_unchecked_rounded),
                            const SizedBox(width: 8),
                            _Chip(
                                text: '$done done',
                                icon: Icons.check_circle_rounded),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text('')),
                  ),
                  loading: () => const SliverFillRemaining(
                    hasScrollBody: false,
                    child: SizedBox.shrink(),
                  ),
                  error: (_) => const SliverFillRemaining(
                    hasScrollBody: false,
                    child: SizedBox.shrink(),
                  ),
                  loaded: (tasks) {
                    if (tasks.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text('No tasks yet.\nTap + to add one.',
                              textAlign: TextAlign.center),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      sliver: SliverList.separated(
                        itemCount: tasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (_, i) {
                          final t = tasks[i];
                          return _TaskCard(
                            task: t,
                            onToggle: () => context
                                .read<TaskBloc>()
                                .add(TaskEvent.toggle(t.id)),
                            onEdit: () => _editDialog(t),
                            onDelete: () => context
                                .read<TaskBloc>()
                                .add(TaskEvent.delete(t.id)),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addDialog,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add task'),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TaskCard({
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Checkbox.adaptive(
              value: task.completed,
              onChanged: (_) => onToggle(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                task.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  decoration:
                      task.completed ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz_rounded),
              onSelected: (v) {
                if (v == 'edit') onEdit();
                if (v == 'delete') onDelete();
              },
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final IconData icon;

  const _Chip({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(text),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  const _ErrorCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.error_outline_rounded),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
