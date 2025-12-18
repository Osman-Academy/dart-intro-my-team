import 'package:dio/dio.dart';
import '../models/character_model.dart';

class CharacterRemoteDataSource{
  final Dio dio;
  CharacterRemoteDataSource(this.dio);

  Future<List<CharacterModel>> fetchCharacters() async{
    final response = await dio.get('/en/characters');
    final List data = response.data;
    return data.map((e) => CharacterModel.fromJson(e)).toList();
  }
}