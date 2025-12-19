import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:string_search_app/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserMapper on UserModel {
  User toEntity() => User(id: id, name: name, email: email);
}
