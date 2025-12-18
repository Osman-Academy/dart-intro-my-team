import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/character.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';
@freezed
class CharacterModel with _$CharacterModel{
  const factory CharacterModel({
    required String id,
    required String name,
    String? house,
    String? image,
  })= _CharacterModel;
  factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);
}

extension CharacterMapper on CharacterModel{
  Character toEntity() => Character(
    id: id,
    name: name,
    house: house,
    image: image,
  );
}