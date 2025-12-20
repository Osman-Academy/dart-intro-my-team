import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/common/di/service_locator.dart';
import 'package:movie_search/features/bloc/movie_bloc.dart';
import 'package:movie_search/features/pages/home_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: BlocProvider(
        create: (context) => MovieBloc(),
        child: const HomePage()
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}