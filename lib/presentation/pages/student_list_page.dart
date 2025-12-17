import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/student_bloc.dart';
import '../bloc/student_event.dart';
import '../bloc/student_state.dart';
import '../../domain/entities/student.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StudentBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key('searchTextField'),
              decoration: const InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                bloc.add(StudentEvent.searchStudents(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: Text('Type to search or wait to load')),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  loaded: (students) => _StudentListView(students: students),
                  error: (msg) => Center(child: Text('Error: $msg')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentListView extends StatelessWidget {
  final List<Student> students;

  const _StudentListView({required this.students});

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) {
      return const Center(child: Text('No students found'));
    }
    return ListView.separated(
      itemCount: students.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final s = students[index];
        return ListTile(
          title: Text(s.name),
          subtitle: Text(s.email),
        );
      },
    );
  }
}