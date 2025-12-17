// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductDtoImpl _$$ProductDtoImplFromJson(Map<String, dynamic> json) =>
    _$ProductDtoImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: json['price'] as num,
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$$ProductDtoImplToJson(_$ProductDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
    };
