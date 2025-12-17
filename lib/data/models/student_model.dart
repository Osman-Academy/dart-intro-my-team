import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/student.dart';

part 'student_model.freezed.dart';
part 'student_model.g.dart';

@freezed
class StudentModel with _$StudentModel {
  const factory StudentModel({
    required String id,
    required String name,
    required String email,
  }) = _StudentModel;

  factory StudentModel.fromJson(Map<String, dynamic> json) => _$StudentModelFromJson(json);
}

extension StudentModelX on StudentModel {
  Student toEntity() {
    return Student(
      id: id,
      name: name,
      email: email,
    );
  }
}