import '../models/character_model.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasource/character_remote_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository{
  final CharacterRemoteDataSource remote;
  CharacterRepositoryImpl(this.remote);

  @override
  Future<List<Character>> getCharacters() async {
    final models = await remote.fetchCharacters();
    return models.map((e) => e.toEntity()).toList();
  }
}