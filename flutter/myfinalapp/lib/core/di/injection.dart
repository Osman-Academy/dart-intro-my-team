import 'package:get_it/get_it.dart';

import '../../features/tasks/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 🔹 BLoC
  sl.registerFactory<TaskBloc>(() => TaskBloc());
}
