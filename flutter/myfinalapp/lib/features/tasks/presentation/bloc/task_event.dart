import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/task.dart';

part 'task_event.freezed.dart';

@freezed
class TaskEvent with _$TaskEvent {
  const factory TaskEvent.load() = _Load;
  const factory TaskEvent.search(String query) = _Search;

  const factory TaskEvent.add(Task task) = _Add;
  const factory TaskEvent.update(Task task) = _Update;
  const factory TaskEvent.delete(int id) = _Delete;
}
