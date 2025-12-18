// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharacterModelImpl _$$CharacterModelImplFromJson(Map<String, dynamic> json) =>
    _$CharacterModelImpl(
      id: (json['index'] as num?)?.toInt(),
      name: json['fullName'] as String?,
      house: json['hogwartsHouse'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$CharacterModelImplToJson(
  _$CharacterModelImpl instance,
) => <String, dynamic>{
  'index': instance.id,
  'fullName': instance.name,
  'hogwartsHouse': instance.house,
  'image': instance.image,
};
