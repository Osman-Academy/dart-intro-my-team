import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/bloc/student_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;
import 'presentation/pages/student_list_page.dart';
import 'presentation/bloc/student_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); 
  runApp(const StudentListApp());
}

class StudentListApp extends StatelessWidget {
  const StudentListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student List App',
      home: BlocProvider(
        create: (context) => di.sl<StudentBloc>()..add(const StudentEvent.loadStudents()),
        child: const StudentListPage(),
      ),
    );
  }
}