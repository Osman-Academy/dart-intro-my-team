// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharacterModelImpl _$$CharacterModelImplFromJson(Map<String, dynamic> json) =>
    _$CharacterModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      house: json['house'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$CharacterModelImplToJson(
  _$CharacterModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'house': instance.house,
  'image': instance.image,
};
