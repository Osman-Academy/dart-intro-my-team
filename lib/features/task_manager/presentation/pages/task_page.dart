import 'dart:math';
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
  final _addCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(const TaskEvent.load());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _addCtrl.dispose();
    super.dispose();
  }

  void _openAddSheet() {
    _addCtrl.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final bottom = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, bottom + 16),
          child: _AddSheet(
            controller: _addCtrl,
            onSubmit: () {
              final title = _addCtrl.text.trim();
              if (title.isNotEmpty) {
                context.read<TaskBloc>().add(TaskEvent.add(title));
                Navigator.pop(context);
              }
            },
          ),
        );
      },
    );
  }

  void _editTask(Task t) {
    final ctrl = TextEditingController(text: t.title);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit task'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'New title…'),
          onSubmitted: (_) => _submitEdit(t, ctrl),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => _submitEdit(t, ctrl), child: const Text('Save')),
        ],
      ),
    );
  }

  void _submitEdit(Task t, TextEditingController ctrl) {
    final title = ctrl.text.trim();
    if (title.isEmpty) return;
    context.read<TaskBloc>().add(TaskEvent.edit(t.copyWith(title: title)));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // stylish background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary.withAlpha(20), Theme.of(context).colorScheme.surface],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.task_alt_rounded, size: 28),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('Ulan Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    ),
                    // Animated progress
                    BlocBuilder<TaskBloc, TaskState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const SizedBox(width: 68, height: 68),
                          loading: () => const SizedBox(width: 68, height: 68, child: CircularProgressIndicator()),
                          error: (_) => const SizedBox(width: 68, height: 68),
                          loaded: (tasks) {
                            final total = tasks.length;
                            final done = tasks.where((t) => t.completed).length;
                            final percent = total == 0 ? 0.0 : done / total;
                            return _RadialProgress(size: 68, value: percent);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              // search
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    hintText: 'Search tasks or patterns…',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _searchCtrl.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () {
                              _searchCtrl.clear();
                              context.read<TaskBloc>().add(const TaskEvent.search(''));
                              setState(() {});
                            },
                          ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                  onChanged: (v) => context.read<TaskBloc>().add(TaskEvent.search(v)),
                ),
              ),

              // body grid
              Expanded(
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(child: SizedBox.shrink()),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (msg) => Center(child: _ErrorPill(message: msg)),
                      loaded: (tasks) {
                        if (tasks.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 36),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.auto_awesome_rounded, size: 64, color: Theme.of(context).colorScheme.primary),
                                  const SizedBox(height: 12),
                                  const Text('No tasks yet — breathe, create one!', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                                  const SizedBox(height: 18),
                                  FilledButton.icon(onPressed: _openAddSheet, icon: const Icon(Icons.add_rounded), label: const Text('Create your first task')),
                                ],
                              ),
                            ),
                          );
                        }

                        // creative staggered grid via Wrap
                        return SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: List.generate(tasks.length, (i) {
                              final t = tasks[i];
                              final size = (i % 3 == 0) ? _CardSize.large : (i % 2 == 0 ? _CardSize.medium : _CardSize.small);
                              return _TaskCardFancy(
                                key: ValueKey(t.id),
                                task: t,
                                size: size,
                                onToggle: () => context.read<TaskBloc>().add(TaskEvent.toggle(t.id)),
                                onEdit: () => _editTask(t),
                                onDelete: () => context.read<TaskBloc>().add(TaskEvent.delete(t.id)),
                              );
                            }),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // bottom bar - add quick
              SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _addCtrl,
                          maxLength: 60,
                          decoration: InputDecoration(
                            hintText: 'Add quick task (press +)',
                            prefixIcon: const Icon(Icons.add_rounded),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onSubmitted: (_) {
                            final txt = _addCtrl.text.trim();
                            if (txt.isNotEmpty) {
                              context.read<TaskBloc>().add(TaskEvent.add(txt));
                              _addCtrl.clear();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton.small(
                        onPressed: _openAddSheet,
                        child: const Icon(Icons.add_task_rounded),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------- Supporting Widgets & Helpers ---------- */

class _RadialProgress extends StatelessWidget {
  final double value;
  final double size;
  const _RadialProgress({required this.value, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: value),
      duration: const Duration(milliseconds: 800),
      builder: (_, v, __) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(value: v, strokeWidth: 5),
              Text('${(v * 100).round()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            ],
          ),
        );
      },
    );
  }
}

enum _CardSize { small, medium, large }

class _TaskCardFancy extends StatelessWidget {
  final Task task;
  final _CardSize size;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TaskCardFancy({
    super.key,
    required this.task,
    required this.size,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  static const _heights = {
    _CardSize.small: 96.0,
    _CardSize.medium: 140.0,
    _CardSize.large: 180.0,
  };

  Color _seedColor(String id) {
    final hash = id.codeUnits.fold<int>(0, (p, c) => p * 31 + c);
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = (hash & 0x0000FF);
    return Color.fromARGB(255, (r % 180) + 40, (g % 180) + 40, (b % 180) + 40);
  }

  @override
  Widget build(BuildContext context) {
    final base = _seedColor(task.id);
    final darker = HSLColor.fromColor(base).withLightness(0.35).toColor();
    final lighter = HSLColor.fromColor(base).withLightness(0.65).toColor();
    final height = _heights[size]!;

    return LayoutBuilder(builder: (context, constraints) {
      final desiredWidth = size == _CardSize.large ? 260.0 : (size == _CardSize.medium ? 220.0 : 160.0);
      final available = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
      final width = min(desiredWidth, max(120.0, available - 24));

      final titleMaxLines = size == _CardSize.small ? 2 : (size == _CardSize.medium ? 3 : 4);
      final titleFontSize = size == _CardSize.small ? 14.0 : (size == _CardSize.medium ? 15.0 : 16.0);

      return AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: task.completed ? 0.55 : 1.0,
        child: InkWell(
          onTap: onToggle,
          onLongPress: onEdit,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [lighter, darker], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: base.withAlpha(56), blurRadius: 10, offset: const Offset(0, 6))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // id pill + delete icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
                      child: Text(task.id.substring(0, min(6, task.id.length)), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline_rounded),
                      iconSize: 20,
                      tooltip: 'Delete',
                      color: Colors.white,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // title
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    task.title,
                    maxLines: titleMaxLines,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 6),

                // compact action row
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white24,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      onPressed: onToggle,
                      icon: Icon(task.completed ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, color: Colors.white, size: 18),
                      label: Text(task.completed ? 'Done' : 'Pending', style: const TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      onPressed: onEdit,
                      child: const Text('Edit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _AddSheet extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  const _AddSheet({required this.controller, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Theme.of(context).colorScheme.surface, boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10),
        ]),
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Create a bright task', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'What\'s the plan?',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onSubmitted: (_) => onSubmit(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: FilledButton(onPressed: onSubmit, child: const Text('Add task'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorPill extends StatelessWidget {
  final String message;
  const _ErrorPill({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.errorContainer, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [const Icon(Icons.error_outline_rounded), const SizedBox(width: 10), Expanded(child: Text(message))]),
    );
  }
}