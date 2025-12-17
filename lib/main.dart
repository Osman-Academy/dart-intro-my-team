import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_finall_project/presentation/bloc/task_event.dart';
import 'injection_container.dart' as di;
import 'package:flutter_application_finall_project/presentation/pages/tasks_page.dart';
import 'package:flutter_application_finall_project/presentation/bloc/task_bloc.dart';
import 'package:flutter_application_finall_project/domain/usecases/get_tasks.dart';
import 'package:flutter_application_finall_project/domain/usecases/add_task.dart';
import 'package:flutter_application_finall_project/domain/usecases/update_task.dart';
import 'package:flutter_application_finall_project/domain/usecases/delete_task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Build all use cases using the repository registered in DI.
    final getTasks = di.sl<GetTasks>();
    final addTask = di.sl<AddTask>();
    final updateTask = di.sl<UpdateTask>();
    final deleteTask = di.sl<DeleteTask>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(
            getTasks: getTasks,
            addTask: addTask,
            updateTask: updateTask,
            deleteTask: deleteTask,
          )..add(const FetchTasks()),
        ),
      ],
      child: MaterialApp(
        title: 'Clean Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const TasksPage(),
      ),
    );
  }
}
