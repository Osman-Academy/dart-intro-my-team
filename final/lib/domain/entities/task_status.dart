import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum TaskStatus { todo, inProgress, done }

String _normalizeStatus(String raw) => raw.replaceAll('-', '').replaceAll('_', '').toLowerCase();

TaskStatus taskStatusFromJson(String raw) =>
    TaskStatus.values.firstWhere((e) => _normalizeStatus(e.name) == _normalizeStatus(raw), orElse: () => TaskStatus.todo);

String taskStatusToJson(TaskStatus status) => status.name.toUpperCase();
