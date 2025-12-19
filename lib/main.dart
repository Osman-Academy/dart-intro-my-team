import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'features/movies/presentation/bloc/movie_search_bloc.dart';
import 'features/movies/presentation/bloc/movie_search_event.dart';
import 'features/movies/presentation/bloc/saved_movies_bloc.dart';
import 'features/movies/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация DI
  await configureDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MovieSearchBloc>()
            ..add(const MovieSearchEvent.loadPopular()),
        ),
        BlocProvider(
          create: (context) => getIt<SavedMoviesBloc>()
            ..add(const SavedMoviesEvent.loadSaved()),
        ),
      ],
      child: MaterialApp(
        title: 'Movie Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}