import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/characters/data/datasource/character_remote_datasource.dart';
import 'features/characters/data/repository/character_repository_impl.dart';
import 'features/characters/presentation/bloc/character_bloc.dart';
import 'features/characters/presentation/bloc/character_event.dart';
import 'features/characters/presentation/pages/characters_page.dart';


void main() {
  configureDependencies();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    final dio = getIt<Dio>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (_) => CharacterBloc(
          CharacterRepositoryImpl(
            CharacterRemoteDataSource(dio),
          ),
        )..add(LoadCharacters()),
        child: const CharactersPage(),
      ),
    );
  }
}