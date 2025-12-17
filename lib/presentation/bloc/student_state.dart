import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/student.dart';

part 'student_state.freezed.dart';

@freezed
class StudentState with _$StudentState {
  const factory StudentState.initial() = _Initial;
  const factory StudentState.loading() = _Loading;
  const factory StudentState.loaded(List<Student> students) = _Loaded;
  const factory StudentState.error(String message) = _Error;
}