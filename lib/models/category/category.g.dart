// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      bookIds:
          (json['bookIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bookIds': instance.bookIds,
      'isDefault': instance.isDefault,
    };
