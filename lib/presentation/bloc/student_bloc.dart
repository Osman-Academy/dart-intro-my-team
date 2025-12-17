import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'student_event.dart';
import 'student_state.dart';
import '../../domain/usecases/get_students.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final GetStudentsUseCase getStudents;
  Timer? _debounceTimer;

  StudentBloc({required this.getStudents}) : super(const StudentState.initial()) {
    on<StudentEvent>((event, emit) async {
      await event.map(
        loadStudents: (e) async {
          final query = e.query;
          emit(const StudentState.loading());
          try {
            final students = await getStudents.call(query: query);
            emit(StudentState.loaded(students));
          } catch (err) {
            emit(StudentState.error(err.toString()));
          }
        },
        searchStudents: (e) async {
          _debounceTimer?.cancel();
          _debounceTimer = Timer(const Duration(seconds: 2), () {
            add(StudentEvent.loadStudents(query: e.query));
          });
        },
      );
    });
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}