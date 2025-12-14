import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/blocs/task_bloc/task_bloc.dart';
import 'presentation/blocs/task_bloc/task_event.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(const TeamFlowApp());
}

class TeamFlowApp extends StatelessWidget {
  const TeamFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TaskBloc()..add(LoadTasksEvent()),
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
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
