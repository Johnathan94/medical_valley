// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestModel _$RegisterRequestModelFromJson(
        Map<String, dynamic> json) =>
    RegisterRequestModel(
      id: json['id'] as int? ?? 1,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      haveInsurance: json['haveInsurance'] as bool?,
      insuranceCompanyId: json['insuranceCompanyId'] as int?,
      nationalId: json['nationalId'] as String?,
      birthDate: json['birthDate'] as String?,
      genderId: json['genderId'] as int?,
      userTypeId: json['userTypeId'] as int? ?? 1,
      notes: json['notes'] as String?,
      genderStr: json['genderStr'] as String?,
      insuranceCompanyStr: json['insuranceCompanyStr'] as String?,
      rememberMe: json['rememberMe'] as bool?,
    );

Map<String, dynamic> _$RegisterRequestModelToJson(
        RegisterRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'mobile': instance.mobile,
      'haveInsurance': instance.haveInsurance,
      'insuranceCompanyId': instance.insuranceCompanyId,
      'nationalId': instance.nationalId,
      'birthDate': instance.birthDate,
      'genderId': instance.genderId,
      'userTypeId': instance.userTypeId,
      'notes': instance.notes,
      'genderStr': instance.genderStr,
      'insuranceCompanyStr': instance.insuranceCompanyStr,
      'rememberMe': instance.rememberMe,
    };
