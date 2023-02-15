// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestModel _$RegisterRequestModelFromJson(
        Map<String, dynamic> json) =>
    RegisterRequestModel(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      haveInsurance: json['haveInsurance'] as bool?,
      genderId: json['genderId'] as int?,
    );

Map<String, dynamic> _$RegisterRequestModelToJson(
        RegisterRequestModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'mobile': instance.mobile,
      'haveInsurance': instance.haveInsurance,
      'genderId': instance.genderId,
    };
