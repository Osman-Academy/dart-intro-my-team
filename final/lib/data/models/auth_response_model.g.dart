// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseModelImpl _$$AuthResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AuthResponseModelImpl(
  token: json['token'] as String,
  user: json['user'] as Map<String, dynamic>,
);

Map<String, dynamic> _$$AuthResponseModelImplToJson(
  _$AuthResponseModelImpl instance,
) => <String, dynamic>{'token': instance.token, 'user': instance.user};
