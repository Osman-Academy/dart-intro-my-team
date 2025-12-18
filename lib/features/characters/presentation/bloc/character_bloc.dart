import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState>{
  final CharacterRepository repository;
  List <Character>allCharacters = [];

  CharacterBloc(this.repository) : super(CharacterLoading()){
    on<LoadCharacters>((event , emit) async {
      try{
        allCharacters = await repository.getCharacters();
        emit(CharacterLoaded(allCharacters));
      }catch(e){
        emit(CharacterError(e.toString()));
      }

    });
    on<SearchCharacters>((event , emit){
      final filtered = allCharacters.where((c) => c.name.toLowerCase().contains(event.query.toLowerCase())).toList();
      emit(CharacterLoaded(filtered));
    });
  }
}
