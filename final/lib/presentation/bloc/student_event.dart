import 'package:freezed_annotation/freezed_annotation.dart';
part 'student_event.freezed.dart';

@freezed
class StudentEvent with _$StudentEvent {
  const factory StudentEvent.loadStudents({String? query}) = _LoadStudents;
  const factory StudentEvent.searchStudents(String query) = _SearchStudents;
}