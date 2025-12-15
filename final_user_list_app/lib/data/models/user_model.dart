// Data Layer - User Model (DTO)
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  
  const factory UserModel({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String website,
    @Default('') String username,
    AddressModel? address,
    CompanyModel? company,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      website: website,
      username: username,
      address: address?.toEntity(),
      company: company?.toEntity(),
    );
  }
}

@freezed
class AddressModel with _$AddressModel {
  const AddressModel._();
  
  const factory AddressModel({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    GeoModel? geo,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);

  Address toEntity() {
    return Address(
      street: street,
      suite: suite,
      city: city,
      zipcode: zipcode,
      geo: geo?.toEntity(),
    );
  }
}

@freezed
class GeoModel with _$GeoModel {
  const GeoModel._();
  
  const factory GeoModel({
    required String lat,
    required String lng,
  }) = _GeoModel;

  factory GeoModel.fromJson(Map<String, dynamic> json) => _$GeoModelFromJson(json);

  Geo toEntity() {
    return Geo(lat: lat, lng: lng);
  }
}

@freezed
class CompanyModel with _$CompanyModel {
  const CompanyModel._();
  
  const factory CompanyModel({
    required String name,
    required String catchPhrase,
    required String bs,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => _$CompanyModelFromJson(json);

  Company toEntity() {
    return Company(
      name: name,
      catchPhrase: catchPhrase,
      bs: bs,
    );
  }
}
