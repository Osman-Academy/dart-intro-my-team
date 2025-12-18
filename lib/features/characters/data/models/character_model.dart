import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/character.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';
@freezed
class CharacterModel with _$CharacterModel{
  const factory CharacterModel({
    @JsonKey(name: 'index') int? id,
    @JsonKey(name: 'fullName')String? name,
    @JsonKey(name: 'hogwartsHouse')String? house,
    String? image,
  })= _CharacterModel;
  factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);
}

extension CharacterMapper on CharacterModel{
  Character toEntity() => Character(
    id: (id ?? 0).toString(),
    name: name ?? 'Unknown',
    house: house,
    image: image,
  );
}