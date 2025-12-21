import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'data/repositories/task_repository_impl.dart';
import 'data/services/token_storage.dart';
import 'presentation/blocs/auth_bloc/auth_bloc.dart';
import 'presentation/blocs/auth_bloc/auth_event.dart';
import 'presentation/blocs/auth_bloc/auth_state.dart';
import 'presentation/blocs/task_bloc/task_bloc.dart';
import 'presentation/blocs/task_bloc/task_event.dart';
import 'presentation/pages/auth_page.dart';
import 'presentation/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await sl.allReady();
  final tokenStorage = sl<TokenStorage>();
  final taskRepo = sl<TaskRepositoryImpl>();

  runApp(TeamFlowApp(
    tokenStorage: tokenStorage,
    taskRepository: taskRepo,
  ));
}

class TeamFlowApp extends StatelessWidget {
  final TokenStorage tokenStorage;
  final TaskRepositoryImpl taskRepository;
  const TeamFlowApp({super.key, required this.tokenStorage, required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(tokenStorage: tokenStorage)..add(AuthCheckRequested()),
        ),
        BlocProvider(
          create: (ctx) => TaskBloc(
            repository: taskRepository,
            onUnauthorized: () => ctx.read<AuthBloc>().add(AuthLogoutRequested()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Team Flow',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4C5DF4)),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF6F7FB),
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'Roboto',
                bodyColor: const Color(0xFF1C1F2E),
                displayColor: const Color(0xFF1C1F2E),
              ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Color(0xFF1C1F2E),
            centerTitle: false,
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1F2E),
            ),
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            shadowColor: Colors.black.withOpacity(0.06),
          ),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.loading) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            if (state.token == null || state.user == null) {
              return AuthPage();
            }
            return const HomePage();
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
